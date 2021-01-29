import tensorflow as tf
from tensorflow.keras.applications import MobileNetV2
from tensorflow.keras.applications.mobilenet_v2 import preprocess_input
from tensorflow.keras.preprocessing.image import ImageDataGenerator

from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report, multilabel_confusion_matrix
import os
import pandas as pd
import numpy as np


""" Hyper parameter """
LR = 0.0001
EPOCHS = 20
BATCH_SIZE = 32
""" Hyper parameter """
MAIN_DIR = '../../data'

dataframe = pd.read_csv(os.path.join(MAIN_DIR, 'dataframe_multilabel.csv'))
# DATASET_SIZE = len(dataframe)
train_df, test_df = train_test_split(dataframe, test_size=0.2)

columns = ['is_capsule', 'white', 'yellow', 'green',
           'red', 'black', 'brown', 'blue', 'purple']
gen = ImageDataGenerator(
    rotation_range=20, width_shift_range=0.2, height_shift_range=0.2,
    horizontal_flip=True, vertical_flip=True,
    preprocessing_function=preprocess_input,
    validation_split=0.2
)
train_gen = gen.flow_from_dataframe(
    dataframe=train_df, x_col='path', y_col=columns,
    batch_size=BATCH_SIZE, shuffle=True, class_mode='raw',
    target_size=(224, 224),
    subset='training'
)
val_gen = gen.flow_from_dataframe(
    dataframe=train_df, x_col='path', y_col=columns,
    batch_size=BATCH_SIZE, shuffle=True, class_mode='raw',
    target_size=(224, 224),
    subset='validation'
)
test_gen = gen.flow_from_dataframe(
    dataframe=test_df, x_col='path', y_col=columns,
    batch_size=BATCH_SIZE, shuffle=True, class_mode='raw',
    target_size=(224, 224)
)

# Define model
base_model = MobileNetV2(
    weights="imagenet",
    include_top=False,
    input_tensor=tf.keras.layers.Input(shape=(224, 224, 3))
)

head_model = base_model.output
head_model = tf.keras.layers.GlobalMaxPooling2D()(head_model)

x = tf.keras.layers.Dense(512)(head_model)
x = tf.keras.layers.BatchNormalization()(x)
x = tf.keras.layers.Activation('relu')(x)

x = tf.keras.layers.Dense(128)(x)
x = tf.keras.layers.BatchNormalization()(x)
x = tf.keras.layers.Activation('relu')(x)

x = tf.keras.layers.Dense(64)(x)
x = tf.keras.layers.BatchNormalization()(x)
x = tf.keras.layers.Activation('relu')(x)

output_layer = tf.keras.layers.Dense(6, activation='sigmoid')(x)

model = tf.keras.models.Model(inputs=base_model.input,
                              outputs=output_layer)

for layer in base_model.layers:
    layer.trainable = False

# model compile
optimizer = tf.keras.optimizers.Adam(LR)
model.compile(
    optimizer=optimizer,
    loss=tf.keras.losses.BinaryCrossentropy(),
    metrics=['acc']
)

# training
TRAIN_STEP = train_gen.n // BATCH_SIZE
VAL_STEP = val_gen.n // BATCH_SIZE
TEST_STEP = test_gen.n // BATCH_SIZE

history = model.fit(
    train_gen,
    steps_per_epoch=TRAIN_STEP,
    validation_data=val_gen,
    validation_steps=VAL_STEP,
    epochs=EPOCHS
)

model.evaluate(test_gen, steps=TEST_STEP)
y_true = test_gen.classes
y_pred = model.predict(test_gen, steps=TEST_STEP)
THRESH = 0.5
y_pred = np.array([[1 if i > THRESH else 0 for i in j] for j in y_pred])

print(classification_report(y_true, y_pred, target_names=columns))
print(multilabel_confusion_matrix(y_true, y_pred))
