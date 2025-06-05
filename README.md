# 📚 Library Management System

A database-driven Python project to manage books, authors, members, and borrowing activities in a library. This system is built using **MySQL** as the backend and **Python** as the frontend interface using `mysql-connector-python`.

---

## 🔍 Project Overview

This project allows librarians or administrators to:
- Manage books, authors, and members
- Record borrowing and return of books
- Automatically calculate late fines
- View and generate reports
- Perform advanced database operations like Views, Triggers, Procedures, and Functions

---

## 💻 Technologies Used

| Component          | Technology         |
|--------------------|--------------------|
| Backend Database   | MySQL              |
| Programming        | Python 3           |
| DB Connector       | mysql-connector-python |
| IDE                | VS Code / PyCharm  |
| Diagram Tool       | Draw.io / DALL·E   |

---

## 🗃️ Database Schema

- **Authors**: `AuthorID`, `Name`, `Country`
- **Books**: `BookID`, `Title`, `AuthorID`, `Category`, `Price`
- **Members**: `MemberID`, `Name`, `JoinDate`
- **Borrowing**: `BorrowID`, `MemberID`, `BookID`, `BorrowDate`, `ReturnDate`, `Fine`

Includes:
- Indexing on `AuthorID` and `BookID`
- View: `BorrowedBooksView`
- Stored Procedure: `GetBooksByCategory`
- User-defined Function: `CalculateFine`
- Trigger: `UpdateFineTrigger`

---

## 🧠 Key Features

- Add / Update / Delete books, members, authors
- Borrow and return books with real-time tracking
- Late fine auto-calculation (₹5/day after 7 days)
- Query reports without using joins
- Clean, menu-driven Python CLI interface

---

## ⚙️ How to Run

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/library-management-system.git

Create the MySQL database:

Import the library.sql file provided in this repo into MySQL.

Install required Python package:
pip install mysql-connector-python

Update your DB credentials in the Python file:
python
Copy
Edit
mydb = mysql.connector.connect(
    host="localhost",
    user="your_username",
    password="your_password",
    database="Library"
)
Run the Python interface:
python library_interface.py

📸 Screenshots
![image](https://github.com/user-attachments/assets/0f512154-b042-45ab-bdf4-f4d1fe6929a1)


📈 Future Enhancements
Build a GUI using Tkinter or Streamlit

Add email notifications for due dates

Role-based login (Admin / Member)

📄 License
This project is for educational purposes and personal learning.

👩‍💻 Author
Tania Khatun
Student at NSTI(W), Kolkata
Pursuing AI Microdegree with a specialization in Python & Database Applications.

📬 Contact
Feel free to connect or give feedback!
📧 Email: sania.khatun18022006@gmail.com
🌐 LinkedIn: : www.linkedin.com/in/tania-khatun-024a30324
