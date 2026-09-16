import streamlit as st
import pandas as pd
import numpy as np

# streamlit 에서 텍스트를 사용하는 방법
"""
title
subtitle
header
write
text
code
markdown
"""

MAIN_TITLE = 'hello, streamlit'
st.title(MAIN_TITLE)
st.header('데이터 애플리케이션')
st.subheader('대시보드 페이지 구성')
st.write('streamlit은 대시보드를 쉽게 구성할 수 있습니다.')
st.caption('쉽게 만들 수 있어요!')
st.markdown('---')
# 마크다운 특성상 줄바꿈이 바로 안됨
st.markdown("""

### 매출 분석 결과
이번 달 주요 지표입니다.

-총 주문수: **1000건**<br/>
-총 매출: 3500000만원<br/>
-평균 주문 금액: 28000원<br/>

매출은 지난 달보다 8.2% 증가했습니다.
""", unsafe_allow_html=True)

st.markdown('---')

scores = [78,85,92,88,95]
score_avg = sum(scores)/len(scores)

st.subheader('학생 평균')
st.markdown(f'현재 학생들의 평균점수는 **{score_avg:.2f}** 점입니다.')

'''shell
streamlit run<실행하고자 하는 파이썬 파일(경로)>

stremlit run ./main.py

'''
st.markdown('---')
#파이참이 제공해주는 기능
example_sql="""
SELECT 
    category, product_name, unit_price
From
    orders
GROUP BY 
    category
"""

st.code(
    example_sql,
    language='sql')



st.markdown('---')
sales= pd.DataFrame({
    '월':[
        '1월',
        '2월',
        '3월',
        '4월',
    ],
    '가격': [
        1200,1500,1350,1800,
    ],
    '판매량': [
        3,
        8,
        15,
        20
    ]
})

sales['매출']= sales['가격']*sales['판매량']

st.title('월별 매출')
st.dataframe(sales)
st.dataframe(sales,
             hide_index=True)

st.write('---')
st.table(sales)

# 이미지는 숫자의 배열(3차원 배열)
st.write('---')

image = np.zeros(
    (200,400,3),
    dtype=np.uint8,
)

image[:,  :200] = [
    80,140,220
]
image[:, 200:]=[
    255,180,70
]

#st.caption('Numpy 배열로 그린 멋진 그림')

# 1,200,150 초록
# st.image(image,'Numpy 배열로 그린 멋진 그림')
# 자동으로 caption 입력됨, 실제 순서가 caption이기에..

st.image(image,caption='Numpy 배열로 그린 멋진 그림')

st.image('고양이.jpg',
         width=200,
         caption='귀여운_고양이.jpg')

st.write('---')

st.title('수식')
st.latex('p=3.141592')
# 문법을 해결하려면 raw - 안에 든 거 전부 글자야

st.latex('p=3.141592\2')
st.latex(r'p=3.141592\2')
st.latex(r'p=\frac{\pi}{2}')
# 수식을 쓸거면 r을 써라
st.latex(r"""
\bar{x}
 =
\frac{1}{n}
\sum_{i=1}^{n} x_i
""")

st.write('---')
st.title('코드 실행 과정 확인')
with st.echo():
    numbers=[10,20,30]
    total=sum(numbers)
st.write(f'합계: {total}')

#

st.write('---')
st.info('데이터는 매일 오전 9시에 갱신됩니다.')
st.success('데이터는 매일 오전 9시에 갱신됩니다.')
st.warning('데이터는 매일 오전 9시에 갱신됩니다.')
st.error('데이터는 매일 오전 9시에 갱신됩니다.')

st.write('---')
score = 85 #이 점수에 따라 상태가 달라짐
st.title('학생 성적 확인')
st.write(f'점수: {score}')
if score>=90:
    st.success('멋져')
elif score>=80:
    st.info('괜찮아요')
else:
    st.warning('힘내세요')







