import os
import sqlite3
import codecs

print("=============== CHECKING DB ===============\n")


def clear_terminal():
    os.system('cls' if os.name == 'nt' else 'clear')


def check_db(db_name: str) -> bool:
    # Verifica se il file db_name esiste nella directory corrente
    if os.path.exists(db_name):
        return True
    else:
        print(f" {db_name} does not exist!\n")
        choice = input("You want to create it?   Y/N\n")
        if choice == 'Y' or 'y':
            with open(os.path.join(os.getcwd(), db_name), 'w') as file:
                file.close()
            return True
        elif choice == 'N' or 'n':
            print("Exiting...\n")
        else:
            print(f"ERROR: {AssertionError}")
            return False


def main():
    db = input("INSERT DATABASE FILENAME: ")
    print("\n")

    if check_db(db):
        print(f"=============== START INITIALIZING DB: {db} ===============\n")
        print("...\n")
        try:
            connection = sqlite3.connect(db)
            with codecs.open('database_schema.sql', encoding='utf-8') as f:
                connection.executescript(f.read())
            connection.commit()
            connection.close()
            clear_terminal()
            print(f"=============== DB: {db} SUCCESSFULLY INITIALIZED! ===============\n")

        except AssertionError as e:
            print(f"ERROR --> {e}\n")


if __name__ == "__main__":
    main()
