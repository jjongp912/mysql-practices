# from emaillistapp.model import findall
import sys
try:
    sys.path.append('C:\PycharmProjects\mysql-practices')
except ImportError:
    raise ImportError('Import Fail')

from emaillistapp import model

def run_list():
    results = model.findall()
    for index,result in enumerate(results):
        print(f'{index+1}:{result["first_name"]}{result["last_name"]}:{result["email"]}')



def run_add():
    firstname = input('first name:')
    lastname = input('last name:')
    email = input('email:')

    model.insert(firstname, lastname, email)

    run_list()

# def run_dalete():
#     email = input('email:')
#     model.deltebyemail(email)
#     run_list()




def main():
    while True:

        cmd = input(f'(l)ist, (a)dd, (q)uit (d)elete > ')

        if cmd == 'q':
            break
        elif cmd == 'l':
            run_list()
        elif cmd == 'a':
            run_add()
        # elif cmd == 'd':
        #     run_dalete()
        else:
            print('알 수 없는 메뉴입니다.')

if __name__ == '__main__':    # __name__ == '__main__' and main()
    main()
