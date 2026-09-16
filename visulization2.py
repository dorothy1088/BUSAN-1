import pandas as pd
import streamlit as st
import matplotlib.pyplot as plt
import seaborn as sns

st.title('Matplotlib 그래프')
sales=pd.DataFrame({
    'month':[
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun'
    ],
    'sales': [
        12.5,
        14.5,
        13.5,
        16.4,
        18.1,
        19.7
    ]
})

fig, ax =plt.subplots(figsize=(8,6))

ax.plot(
    sales['month'],
    sales['sales'],
    marker='o',
)

ax.set_title('Monthly sales')

ax.set_xlabel('Month')
ax.set_ylabel('Sales')

st.pyplot(fig)
#쥬피터는 축만 필요했지만 우리는 지금 스트림잇에 보내야 하기 때문에 fig를 넣어야 됨
plt.close(fig)
#그림 그만 그려도 돼.알려줘야 함.

st.title('Seaborn 그래프')
fig, ax = plt.subplots(figsize=(8,6))
sns.barplot(
    data=sales,
    x='month',
    y='sales',
    ax=ax,
)
ax.set_title('Monthly sales')
ax.set_xlabel('Month')
ax.set_ylabel('Sales')

st.pyplot(fig)
plt.close(fig)








