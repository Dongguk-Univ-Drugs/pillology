import tensorflow as tf
from tensorflow.keras.applications import MobileNetV2
from tensorflow.keras.applications.mobilenet_v2 import preprocess_input
from tensorflow.keras.preprocessing.image import img_to_array, load_img

import os
import pandas as pd
import matplotlib.pyplot as plt


""" Hyper parameter """
LR = 0.0001
EPOCHS = 10
BATCH_SIZE = 32
""" Hyper parameter """
MAIN_DIR = './data'

dataframe = pd.read_csv(os.path.join(MAIN_DIR, 'dataframe.csv'))
DATASET_SIZE = len(dataframe)


def get_data():
    shape_to_index = {
        '원형': 0,
        '장방형': 1,
        '타원형': 1,
        '각형': 0,
        '기타': 0
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
    f_colors = df['front_color']
    b_colors = df['back_color']

    for img_dir, shape, f_color, b_color in zip(images, shapes, f_colors, b_colors):
        try:
            shape = shape_to_index[shape]
            f_color = color_to_index[f_color]
            b_color = color_to_index[b_color]
            outputs = (shape, f_color, b_color)
            img = load_img(img_dir, target_size=(224, 224))
            img = img_to_array(img)
            img = preprocess_input(img)
            yield img, outputs

        except GeneratorExit:
            return


dataset = tf.data.Dataset.from_generator(
    get_data,
    output_types=(tf.float32, (tf.int32, tf.int32, tf.int32)),
    output_shapes=(tf.TensorShape([224, 224, 3]),
                   (tf.TensorShape([]), tf.TensorShape([]), tf.TensorShape([]))),
)


train_size = int(0.8 * DATASET_SIZE)
test_size = int(0.2 * DATASET_SIZE)

dataset = dataset.shuffle(buffer_size=2048)
train_ds = dataset.take(train_size)
test_ds = dataset.skip(train_size)


""" Define Model """
base_model = MobileNetV2(
    weights="imagenet",
    include_top=False,
    input_tensor=tf.keras.layers.Input(shape=(224, 224, 3))
)


head_model = base_model.output
head_model = tf.keras.layers.GlobalMaxPooling2D()(head_model)

y = tf.keras.layers.Dense(512)(head_model)
y = tf.keras.layers.BatchNormalization()(y)
y = tf.keras.layers.Activation('relu')(y)

x = tf.keras.layers.concatenate([head_model, y])
x = tf.keras.layers.Dense(512)(x)
x = tf.keras.layers.BatchNormalization()(x)
x = tf.keras.layers.Activation('relu')(x)

y = tf.keras.layers.Dense(128)(y)
y = tf.keras.layers.BatchNormalization()(y)
y = tf.keras.layers.Activation('relu')(y)

x = tf.keras.layers.concatenate([x, y])
x = tf.keras.layers.Dense(128)(x)
x = tf.keras.layers.BatchNormalization()(x)
x = tf.keras.layers.Activation('relu')(x)

y = tf.keras.layers.Dense(64)(y)
y = tf.keras.layers.BatchNormalization()(y)
y = tf.keras.layers.Activation('relu')(y)

x = tf.keras.layers.concatenate([x, y])
x = tf.keras.layers.Dense(64)(x)
x = tf.keras.layers.BatchNormalization()(x)
x = tf.keras.layers.Activation('relu')(x)

shape_layer = tf.keras.layers.Dense(1, activation='sigmoid', name='shape_layer')(y)
f_color_layer = tf.keras.layers.Dense(5, activation='softmax', name='f_color_layer')(x)
b_color_layer = tf.keras.layers.Dense(5, activation='softmax', name='b_color_layer')(x)

model = tf.keras.models.Model(inputs=base_model.input,
                              outputs=[shape_layer, f_color_layer, b_color_layer])

for layer in base_model.layers:
    layer.trainable = False

""" model compile """
optimizer = tf.keras.optimizers.Adam(LR)
model.compile(
    optimizer=optimizer,
    loss={'shape_layer': tf.keras.losses.BinaryCrossentropy(),
          'f_color_layer': tf.keras.losses.SparseCategoricalCrossentropy(),
          'b_color_layer': tf.keras.losses.SparseCategoricalCrossentropy()},
    metrics={'shape_layer': 'acc', 'f_color_layer': 'acc', 'b_color_layer': 'acc'}
)

history = model.fit(
    train_ds.batch(BATCH_SIZE),
    validation_data=test_ds.batch(BATCH_SIZE),
    epochs=EPOCHS
)

metric_shape = history.history['shape_layer_acc']
metric_f_color = history.history['f_color_layer_acc']
metric_b_color = history.history['b_color_layer_acc']

val_metric_shape = history.history['val_shape_layer_acc']
val_metric_f_color = history.history['val_f_color_layer_acc']
val_metric_b_color = history.history['val_b_color_layer_acc']

loss = history.history['loss']
val_loss = history.history['val_loss']

plt.plot(range(len(metric_shape)), metric_shape, label='train_shape')
plt.plot(range(len(metric_f_color)), metric_f_color, label='train_front_color')
plt.plot(range(len(metric_b_color)), metric_b_color, label='train_back_color')
plt.plot(range(len(val_metric_shape)), val_metric_shape, label='val_shape')
plt.plot(range(len(val_metric_f_color)), val_metric_f_color, label='val_front_color')
plt.plot(range(len(val_metric_b_color)), val_metric_b_color, label='val_back_color')
plt.legend()
plt.title("Accuracy")

plt.plot(range(len(loss)), loss, label='train')
plt.plot(range(len(val_loss)), val_loss, label='validation')
plt.legend()
plt.title("Loss")

plt.show()
