import os
import re
import pandas as pd
from glob import glob

MAIN_DIR = './data'

""" Set your Image directory """
IMAGE_DIR = 'D:/drug/image'
all_image_path = glob(os.path.join(IMAGE_DIR, '*.jpg'))
imageid_path_dict = {int(os.path.splitext(os.path.basename(x))[0]): x for x in all_image_path}
""" Set your Image directory """


def reduce_shape(txt):
    """
    반원형 -> 기타
    ~각형, 마름모형 -> 각형 or 기타
    """
    if txt == '마름모형' or '각형' in txt:
        return '각형'
    elif txt == '반원형':
        return '기타'
    else:
        return txt


dict_colors = {
    'white': '하양',
    'yellow': '노랑주황',
    'green': '초록연두청록',
    'red_brown': '분홍빨강갈색',
    'black_blue_purple': '파랑남색보라자주회색검정',
}


def reduce_color(txt):
    txt = re.sub('[, 투명진한]', '', txt)
    if len(txt) > 2:
        return 'etc'
    else:
        for k, i in dict_colors.items():
            if txt in i:
                return str(k)


def preprocessing(dataframe):
    dataframe = dataframe.copy()
    dataframe.drop_duplicates(['품목일련번호'], keep='first', inplace=True)
    dataframe = dataframe[dataframe['표시앞'].isna() == False]
    dataframe['shape'] = dataframe['의약품제형'].apply(reduce_shape)
    dataframe['color'] = dataframe['색상앞'].apply(reduce_color)
    dataframe = dataframe[dataframe['color'] != 'etc']
    dataframe['path'] = dataframe['품목일련번호'].map(imageid_path_dict.get)

    """ 식품의약품안전처에서 이미지 제공에 에러가 발생하는 것들 """
    dataframe.drop(dataframe[dataframe['품목일련번호'] == 200502251].index,
                   axis=0, inplace=True)
    dataframe.drop(dataframe[dataframe['품목일련번호'] == 201603799].index,
                   axis=0, inplace=True)
    dataframe = dataframe[['품목일련번호', 'shape', 'color', 'path']]
    return dataframe


if __name__ == '__main__':
    data = data = pd.read_excel(
        os.path.join(MAIN_DIR, '공공데이터개방_낱알식별목록.xlsx'),
        sheet_name='Sheet0', engine='openpyxl'
    )
    data = preprocessing(data)
    print(data.head())
    data.to_csv(os.path.join(MAIN_DIR, 'dataframe.csv'), index=False)
