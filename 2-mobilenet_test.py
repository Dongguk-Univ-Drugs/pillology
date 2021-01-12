import tensorflow as tf
from tensorflow.keras.applications import MobileNetV2
from tensorflow.keras.applications.mobilenet_v2 import preprocess_input
from tensorflow.keras.preprocessing.image import img_to_array, load_img

import os
import pandas as pd


""" Hyper parameter """
LR = 0.0001
EPOCHS = 5
BATCH_SIZE = 32
""" Hyper parameter """
MAIN_DIR = './data'

dataframe = pd.read_csv(os.path.join(MAIN_DIR, 'dataframe.csv'))
DATASET_SIZE = len(dataframe)
del dataframe


def get_data():
    shape_to_index = {
        '원형': 0,
        '장방형': 1,
        '타원형': 2,
        '각형': 3,
        '기타': 4
    }
    color_to_index = {
        'white': 0,
        'red_brown': 1,
        'yellow': 2,
        'green': 3,
        'black_blue_purple': 4
    }
    df = pd.read_csv(os.path.join(MAIN_DIR, 'dataframe.csv'))
    images = df['path']
    shapes = df['shape']
    colors = df['color']

    for img_dir, shape, color in zip(images, shapes, colors):
        try:
            shape = shape_to_index[shape]
            color = color_to_index[color]
            outputs = (shape, color)
            img = load_img(img_dir, target_size=(224, 224))
            img = img_to_array(img)
            img = preprocess_input(img)
            yield img, outputs

        except GeneratorExit:
            return


dataset = tf.data.Dataset.from_generator(
    get_data,
    output_types=(tf.float32, (tf.int32, tf.int32)),
    output_shapes=(tf.TensorShape([224, 224, 3]), (tf.TensorShape([]), tf.TensorShape([]))),
)


train_size = int(0.8 * DATASET_SIZE)
# val_size = int(0.1 * DATASET_SIZE)
test_size = int(0.2 * DATASET_SIZE)
#
dataset = dataset.shuffle(buffer_size=2048)
train_ds = dataset.take(train_size)
test_ds = dataset.skip(train_size)
# val_ds = test_ds.skip(test_size)
# test_ds = test_ds.take(test_size)


""" Define Model """
base_model = MobileNetV2(
    weights="imagenet",
    include_top=False,
    input_tensor=tf.keras.layers.Input(shape=(224, 224, 3))
)

head_model = base_model.output
x = tf.keras.layers.GlobalAveragePooling2D()(head_model)

x = tf.keras.layers.Dense(1024)(x)
x = tf.keras.layers.BatchNormalization()(x)
x = tf.keras.layers.Activation('relu')(x)

x = tf.keras.layers.Dense(512)(x)
x = tf.keras.layers.BatchNormalization()(x)
x = tf.keras.layers.Activation('relu')(x)

x = tf.keras.layers.Dense(256)(x)
x = tf.keras.layers.BatchNormalization()(x)
x = tf.keras.layers.Activation('relu')(x)

x = tf.keras.layers.Dense(128)(x)
x = tf.keras.layers.BatchNormalization()(x)
x = tf.keras.layers.Activation('relu')(x)

shape_layer = tf.keras.layers.Dense(5, activation='softmax', name='shape_layer')(x)
color_layer = tf.keras.layers.Dense(5, activation='softmax', name='color_layer')(x)

model = tf.keras.models.Model(inputs=base_model.input,
                              outputs=[shape_layer, color_layer])

for layer in base_model.layers:
    layer.trainable = False

""" model compile """
optimizer = tf.keras.optimizers.Adam(LR)
model.compile(
    optimizer=optimizer,
    loss={'shape_layer': tf.keras.losses.SparseCategoricalCrossentropy(),
          'color_layer': tf.keras.losses.SparseCategoricalCrossentropy()},
    metrics={'shape_layer': 'accuracy', 'color_layer': 'accuracy'}
)

history = model.fit(
    train_ds.batch(BATCH_SIZE),
    validation_data=test_ds.batch(BATCH_SIZE),
    epochs=EPOCHS
)
