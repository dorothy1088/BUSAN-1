import streamlit as st
st.title('버튼 실습')
clicked= st.button('확인')
st.write(f'버튼 상태 : {clicked}')

if st.button('분석시작'):
    st.success('데이터 분석이 성공적으로 시작되었습니다.')
# 트리거로 많이 쓰임

