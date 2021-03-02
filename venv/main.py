from flask import Flask, render_template, url_for, request, redirect, session, flash, Response
from flask_mysqldb import MySQL
from flask_sqlalchemy import SQLAlchemy
import MySQLdb.cursors
import re
import bcrypt
import base64

app = Flask(__name__)




app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'biblioteka'

mysql = MySQL(app)


app.secret_key = 'secret key'

#rejestracja
@app.route('/registration', methods=['GET', 'POST'])
def registration():
    if request.method == 'POST':
        userDetails = request.form
        first_name = userDetails['first_name']
        email = userDetails['email']
        password = userDetails['password'].encode("utf-8")
        password_confirm = userDetails['password-confirm'].encode("utf-8")
        cursor = mysql.connect.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT email FROM users WHERE email=%s ',[email])
        ver = cursor.fetchone()
        if ver:
            flash('To konto już istnieje. Zaloguj się!')
            return redirect(url_for('index'))
        else:
            if password == password_confirm:
                password = userDetails['password'].encode("utf-8")
                cur = mysql.connection.cursor()
                cur.execute("INSERT INTO users(first_name, email, password) VALUES (%s, %s, %s)", (first_name, email, base64.b64encode(password)))
                mysql.connection.commit()
                cur.close()
                flash('Rejestracja przebiegła pomyślnie! Zaloguj się!')
                return redirect(url_for('index'))
            else:
                flash('Hasła nie są takie same!')
                return redirect(url_for('index'))


#login
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        userDetails = request.form
        email = userDetails['email']
        password = userDetails['password'].encode("utf-8")
        cursor = mysql.connect.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM users WHERE email = %s AND password = %s', (email, base64.b64encode(password,)))
        account = cursor.fetchone()
        if account:
            #zalogowany = 'tak'
            session['loggedin'] = True
            session['email'] = account['email']
            session['first_name'] = account['first_name']
            session['last_name'] = account['last_name']
            session['ID_user'] = account['ID_user']
            session['is_admin'] = account['is_admin']
            session['is_approved'] = account['is_approved']
            return redirect(url_for('main'))
        else:
            flash('Niepoprawny login lub hasło!')
            return redirect(url_for('index'))

#index
@app.route('/', methods=['GET', 'POST'])
def index():
    login()
    return render_template('index.html')


#książki - admin
@app.route('/main', methods=['GET', 'POST'])
def main():
    if session:
        if session['is_admin'] =="TAK":
            cur = mysql.connection.cursor()
            cur.execute("SELECT * FROM books")
            data = cur.fetchall()
            return render_template('main.html', books=data)
        else:
            cur = mysql.connection.cursor()
            cur.execute("SELECT * FROM books")
            data = cur.fetchall()
            return render_template('main_user.html', books=data)
    else:
        return render_template('index.html')


#edycja użytkownika przez użytkownika
@app.route('/edit_user', methods=['GET','POST'])
def edit_user():
    if session:
        cur = mysql.connection.cursor()
        cur.execute()
        cur.execute("SELECT first_name, last_name, email, user_phone_number, user_address_street, user_address_city, user_PESEL FROM users")
        data = cur.fetchall()
        return render_template('edit_user.html', user = data)
    else:
        return render_template('index.html')

#przeczytane książki
@app.route('/borrow_user', methods=['GET', 'POST'])
def borrow_user():
    if session:
        cur = mysql.connection.cursor()
        ID_user = session['ID_user']
        cur.execute("SELECT ID_book, book_name FROM booked WHERE is_borrow_back='TAK' AND ID_user=%s", [ID_user])
        data = cur.fetchall()
        return render_template('borrow_user.html', borrow_user = data)
    else:
        return render_template('index.html')


#zarezerwowane książki
@app.route('/booked_user', methods=['GET', 'POST'])
def booked_user():
    if session:
        cur = mysql.connection.cursor()
        ID_user = session['ID_user']
        cur.execute("SELECT ID_book, book_name FROM booked WHERE is_borrow_back='NIE' AND is_borrow='NIE' AND ID_user=%s", [ID_user])
        data = cur.fetchall()
        return render_template('booked_user.html', booked_user = data)
    else:
        return render_template('index.html')


#wypożyczone książki
@app.route('/borrowed_now', methods=['GET', 'POST'])
def borrowed_now():
    if session:
        cur = mysql.connection.cursor()
        ID_user = session['ID_user']
        cur.execute("SELECT ID_book, book_name FROM booked WHERE is_borrow_back='NIE' AND is_borrow='TAK' AND ID_user=%s", [ID_user])
        data = cur.fetchall()
        return render_template('borrowed_now.html', borrowed_now = data)
    else:
        return render_template('index.html')


#strona z książkami do wypożyczenia
@app.route('/main_user', methods=['GET', 'POST'])
def main_user():
    if session:
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM books")
        data = cur.fetchall()
        return render_template('main_user.html', books = data)
    else:
        return render_template('index.html')


#strona z użytkownikami
@app.route('/users', methods=['GET', 'POST'])
def users():
    if  session:
        if session['is_admin'] =="TAK":
            cur = mysql.connection.cursor()
            cur.execute("SELECT ID_user, first_name, last_name, email, user_phone_number, user_address_street, user_address_city, user_PESEL, is_approved FROM users")
            data = cur.fetchall()
            return render_template('users.html', users = data)
        else:
            cur = mysql.connection.cursor()
            cur.execute("SELECT * FROM books")
            data = cur.fetchall()
            return render_template('main_user.html', books=data)
    else:
        return render_template("index.html")


#strona z rezerwacją ksiazki
@app.route('/booked_books', methods=['GET', 'POST'])
def booked_books():
    if session:
        if session['is_admin']=="TAK":
            cur = mysql.connection.cursor()
            cur.execute("SELECT ID_booked, ID_book, book_name, ID_user, first_name, last_name, email FROM booked WHERE is_borrow = 'NIE'")
            data = cur.fetchall()
            return render_template('booked.html', booked = data)
        else:
            cur = mysql.connection.cursor()
            cur.execute("SELECT * FROM books")
            data = cur.fetchall()
            return render_template('main_user.html', books=data)
    else:
        return render_template('index.html')


#strona z wypożyczeniami ksiazki
@app.route('/borrow_books', methods=['GET', 'POST'])
def borrow_books():
    if session:
        if session['is_admin'] == 'TAK':
            cur = mysql.connection.cursor()
            cur.execute("SELECT ID_booked, ID_book, book_name, ID_user, first_name, last_name, email FROM booked WHERE is_borrow_back = 'NIE' AND is_borrow = 'TAK'" )
            data = cur.fetchall()
            return render_template('borrow.html', borrow = data)
        else:
            cur = mysql.connection.cursor()
            cur.execute("SELECT * FROM books")
            data = cur.fetchall()
            return render_template('main_user.html', books=data)
    else:
        return render_template('index.html')


#dodawanie książki
@app.route('/insert', methods = ['POST'])
def insert():
    if request.method == 'POST':
        title = request.form['title']
        author_first_name = request.form['author_first_name']
        author_last_name = request.form['author_last_name']
        book_category = request.form['book_category']
        publication_date = request.form['publication_date']
        quantity = request.form['quantity']
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO books(book_name, book_author_first_name, book_author_last_name, book_category, book_publication_year, books_quantity) VALUES (%s,%s,%s,%s,%s,%s)", (title,author_first_name,author_last_name,book_category,publication_date,quantity))
        mysql.connection.commit()
        cur.close()

        flash("Książka została dodana pomyślnie!")

        return redirect(url_for('main'))


#dodawanie użytkowników
@app.route('/insert_users', methods = ['POST'])
def insert_users():
    if request.method == 'POST':
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        email = request.form['email']
        user_phone_number = request.form['user_phone_number']
        user_address_street = request.form['user_address_street']
        user_address_city = request.form['user_address_city']
        user_PESEL = request.form['user_PESEL']
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO users(first_name, last_name, email, user_phone_number, user_address_street, user_address_city, user_PESEL) VALUES (%s,%s,%s,%s,%s,%s,%s)", (first_name, last_name, email, user_phone_number, user_address_street, user_address_city, user_PESEL))
        mysql.connection.commit()
        cur.close()

        flash("Użytkownik został dodany pomyślnie!")

        return redirect(url_for('users'))


#update ksiażki
@app.route('/update', methods = ['GET', 'POST'])
def update():
    if request.method == 'POST':
        id = request.form['id']
        title = request.form['title']
        author_first_name = request.form['author_first_name']
        author_last_name = request.form['author_last_name']
        book_category = request.form['book_category']
        publication_date = request.form['publication_date']
        quantity = request.form['quantity']
        cur = mysql.connection.cursor()
        cur.execute("UPDATE books SET book_name = %s, book_author_first_name = %s, book_author_last_name = %s, book_category = %s, book_publication_year = %s, books_quantity = %s WHERE ID_book = %s", (title,author_first_name,author_last_name,book_category,publication_date,quantity, id))
        mysql.connection.commit()
        cur.close()

        flash("Książka została edytowana pomyślnie!")

        return redirect(url_for('main'))


#update_użytkowników
@app.route('/update_users', methods = ['GET', 'POST'])
def update_users():
    if request.method == 'POST':
        ID_user = request.form['ID_user']
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        email = request.form['email']
        user_phone_number = request.form['user_phone_number']
        user_address_street = request.form['user_address_street']
        user_address_city = request.form['user_address_city']
        user_PESEL = request.form['user_PESEL']
        cur = mysql.connection.cursor()
        cur.execute("UPDATE users SET first_name=%s, last_name=%s, email=%s, user_phone_number=%s, user_address_street=%s, user_address_city=%s, user_PESEL=%s WHERE ID_user=%s", (first_name, last_name, email, user_phone_number, user_address_street, user_address_city, user_PESEL, ID_user))
        mysql.connection.commit()
        cur.close()

        flash("Użytkownik został edytowany pomyślnie!")

        return redirect(url_for('users'))


#usuwanie książki
@app.route('/delete/<id>', methods = ['GET', 'POST'])
def delete(id):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM books WHERE ID_book = %s", [id])
    mysql.connection.commit()
    cur.close()

    flash("Książka została usunięta!")

    return redirect(url_for('main'))


#usuwanie_użytkowników
@app.route('/delete_users/<ID_user>', methods = ['GET', 'POST'])
def delete_users(ID_user):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM users WHERE ID_user = %s", [ID_user])
    mysql.connection.commit()
    cur.close()

    flash("Użytkownik został usunięty!")

    return redirect(url_for('users'))


#usuwanie rezerwacji
@app.route('/delete_booked/<ID_booked>', methods = ['GET', 'POST'])
def delete_booked(ID_booked):
    ID_book = mysql.connection.cursor()
    ID_book.execute("SELECT ID_book FROM booked WHERE ID_booked=%s", [ID_booked])
    ID_book.close()
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM booked WHERE ID_booked = %s", [ID_booked])
    cur.execute("UPDATE books SET books_quantity = (books_quantity +1) WHERE ID_book=%s", (ID_book))
    mysql.connection.commit()
    cur.close()

    flash("Rezerwacja została usunięta!")

    return redirect(url_for('booked_books'))


#oddawanie książki
@app.route('/borrow_back/<ID_booked>', methods = ['GET', 'POST'])
def borrow_back(ID_booked):
    ID_book = mysql.connection.cursor()
    ID_book.execute("SELECT ID_book FROM booked WHERE ID_booked=%s", [ID_booked])
    ID_book.close()
    cur = mysql.connection.cursor()
    cur.execute("UPDATE booked SET is_borrow_back = 'TAK' WHERE ID_booked=%s", [ID_booked])
    cur.execute("UPDATE books SET books_quantity = (books_quantity +1) WHERE ID_book=%s", (ID_book))
    mysql.connection.commit()
    cur.close()
    flash("Książka została oddana!")

    return redirect(url_for('borrow_books'))


#wypożyczanie książki
@app.route('/borrow_book/<ID_booked>', methods = ['GET', 'POST'])
def borrow_book(ID_booked):
    cur = mysql.connection.cursor()
    cur.execute("UPDATE booked SET is_borrow = 'TAK' WHERE ID_booked=%s", [ID_booked])
    mysql.connection.commit()
    cur.close()

    flash("Książka została wypożyczona!")

    return redirect(url_for('booked_books'))


#autoryzacja użytkownika
@app.route('/authorization/<ID_user>', methods = ['GET', 'POST'])
def authorization(ID_user):
    cur = mysql.connection.cursor()
    cur.execute("UPDATE users SET is_approved = 'TAK' WHERE ID_user=%s  ", [ ID_user])
    mysql.connection.commit()
    cur.close()

    flash("Użytkownik został zatwierdzony!")

    return redirect(url_for('users'))


#wylogowanie
@app.route('/logout')
def logout():
    session.clear()
    zalogowany = 'Nie'
    return render_template("index.html")


#rezerwacja książki
@app.route('/reservation', methods = ['GET', 'POST'])
def reservation():
    if request.method == 'POST':
        id = request.form['id']
        book_name = request.form['title']
        ID_user = session['ID_user']
        first_name = session['first_name']
        last_name = session['last_name']
        email = session['email']
        quantity = int(request.form['quantity'])
        if session['is_approved'] == "TAK":
            if quantity > 0:
                cur = mysql.connection.cursor()
                cur.execute("INSERT INTO booked(ID_book, book_name, ID_user, first_name, last_name, email) VALUES (%s,%s,%s,%s,%s,%s)", (id, book_name, ID_user, first_name, last_name, email))
                cur.execute("UPDATE books SET books_quantity =%s WHERE ID_book=%s", (quantity-1, id))
                mysql.connection.commit()
                cur.close()
                flash("Książka została zarezerwowana pomyślnie!")
                return redirect(url_for('main_user'))
            else:
                flash('Nie można zarezerwować książki, ponieważ wszystkie książki zostały wypożyczone!')
                return redirect(url_for('main_user'))
        else:
            flash("Nie możesz zarezerwować książki, ponieważ twoje konto nie uzyskało autoryzacji!")
            return redirect(url_for('main_user'))


if __name__ == "__main__":
    app.run(debug=True)

