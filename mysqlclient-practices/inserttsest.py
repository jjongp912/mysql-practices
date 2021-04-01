from MySQLdb import connect, OperationalError
from MySQLdb.cursors import DictCursor

try:
    # 연결
    db = connect(
        user='webdb',
        password='webdb',
        host='localhost',
        port=3306,
        db='webdb',
        charset='utf8')
    print('ok')

    # cursor 생성
    cursor = db.cursor(DictCursor)

    # SQL 실행
    sql = 'insert into emaillist values(null, "마", "이콜", "jjongp912@naver.com")'
    count = cursor.execute(sql)

    # commit
    db.commit()

    #자원 정리
    cursor.close()
    db.close()

    #결과 보기
    print(f'실행결과: {count==1}')


except OperationalError as e:
    print(f'error: {e}')