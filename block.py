class Block(tf.keras.Model):
    def __init__(self, filters=[1024, 512, 256, 128],
                 activation='relu', dropout=None, batch_norm=True):
        super(Block, self).__init__()
        self.filters = filters
        self.activation = activation
        self.dropout = dropout
        self.batch_norm = batch_norm

        for i, filter in enumerate(self.filters):
            vars(self)[f'fc_{i + 1}'] = tf.keras.layers.Dense(filter)

    def call(self, inputs):
        fc_1 = vars(self)['fc_1']
        for i in range(2, len(self.filters)):
            x = fc_1(inputs)