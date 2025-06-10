# Ryan Bernal
# Purpose: Simulate a University Database by using SQLite3 and Python to enroll students in and out of classes and check records.

import sqlite3
import string

def printIntroduction():
    """
    Purpose: Print out a guide for how the User should start with the application.
    Parameters: None
    Pre: None
    Post: None
    Return: None
    Raise: None
    """

    # Introduction and Information for the User
        print("Welcome to Cool University.\n")
        print("Enter the number of your choice.\n")

        print("'I would like to...'")
        print("1. Insert a student")
        print("2. Enroll a student")
        print("3. Unenroll a student")
        print("4. Update a student record")
        print("5. See all the courses")
        print("6. See a student's enrollments")
        print("7. See how many are enrolled in a course")
        print("8. Exit\n")

def insertStudent(cursor, connection):
    """
    Purpose: Insert a brand new student into the Student database
    Parameters: cursor - middleware between the database and the application, connection - the line to the database
    Pre: None
    Post: Student Database receives new student entry
    Return: None
    Raise: Error if User tries to enter anything else than an integer for new_sID
    """

    print("You entered 1. Insert a student \n")

    # Retrieve new student information
    new_sID = int(input("Please enter the student's ID: "))
    new_fName = input("Please enter the student's first name: ")
    new_lName = input("Please enter the student's last name: ")
    new_major = input("Please enter the student's major: ")

    # Insert student information into database
    cursor.execute('''INSERT INTO Student(sID, fName, lName, major) VALUES(?,?,?,?)''', (new_sID, new_fName, new_lName, new_major))
    connection.commit()

def enrollStudent(cursor, connection):
    """
    Purpose: Enroll a student into a class and insert them into the Enrollment database
    Parameters: cursor - middleware between the database and the application, connection - the line to the database
    Pre: None
    Post: Enrollment Database receives new student entry
    Return: None
    Raise: Error if User tries to enter anything else than an integer for new_sID or new_cID
    """

    print("You entered 2. Enroll a student \n")

    # Enter target studentID and courseID
    new_sID = int(input("Please enter the student's ID: "))
    new_cID = int(input("Please enter the course ID: "))

    cursor.execute(f"SELECT * FROM Student WHERE sID = {new_sID}")
    row1 = cursor.fetchall()
    cursor.execute(f"SELECT * FROM Course WHERE cID = {new_cID}")
    row2 = cursor.fetchall()

    # If student or course could not be verified
    if len(row1) == 0 or len(row2) == 0:
        print("Student ID and/or Course ID Invalid. Try again \n")

    # Add enrollment of student into course and log into database
    else:
        print("Student has been successfully registered into the course!\n")
        cursor.execute('''INSERT INTO Enrollment(sID, cID, grade) VALUES(?,?,?)''', (new_sID, new_cID, 'N'))
        connection.commit()

def unenrollStudent(cursor, connection):
    """
    Purpose: Remove a student from a class and the Enrollment database
    Parameters: cursor - middleware between the database and the application, connection - the line to the database
    Pre: Student and course should exist in the Enrollment database
    Post: Student gets removed from course and the Enrollment database
    Return: None
    Raise: Error if User tries to enter anything else other than an integer for new_sID or new_cID
    """
    
    print("You entered 3. Unenroll a student \n")

    # Enter target studentID and courseID
    new_sID = int(input("Please enter the student's ID: "))
    new_cID = int(input("Please enter the course ID: "))

    cursor.execute(f"SELECT * FROM Student WHERE sID = {new_sID}")
    row1 = cursor.fetchall()
    cursor.execute(f"SELECT * FROM Course WHERE cID = {new_cID}")
    row2 = cursor.fetchall()

    # If student or course could not be verified
    if len(row1) == 0 or len(row2) == 0:
        print("Student ID and/or Course ID Invalid. Try again \n")

    # Remove student from course and database
    else:
        print("Student has been unenrolled from the course!\n")
        cursor.execute(f"DELETE FROM Enrollment WHERE sID = {new_sID} AND cID = {new_cID}")
        connection.commit()

def updateRecord(cursor, connection):
    """
    Purpose: Update an existing students record in the Student Database
    Parameters: cursor - middleware between the database and the application, connection - the line to the database
    Pre: Student must exist in the Student database
    Post: Student record in the database gets updated
    Return: None
    Raise: Error if User tries to enter anything else other than an integer for target_sID
    """

    print("You entered 4. Update a student record \n")

    # Enter target studentID
    target_sID = int(input("Enter the student's ID whose record you want to update: "))
    cursor.execute(f"SELECT * FROM Student WHERE sID = {target_sID}")
    row = cursor.fetchall()

    # If student could not be verified
    if len(row) == 0:
        print("Student ID Invalid. Try again ")
    
    # Ask User which part of the student record should be updated
    else:
        inserted = False
        while (inserted == False):
            print("Which attribute of the student do you want to update? ")
            print("1. The student's ID")
            print("2. The student's first name")
            print("3. The student's last name")
            print("4. The student's major\n")

            sDecision = input("What is your choice? ")

            # Change studentID
            if (sDecision == "1"):
                new_sID = int(input("Please enter the student's new ID: "))
                cursor.execute(f"UPDATE Student SET sID = '{new_sID}' WHERE sID = {target_sID}")
                connection.commit()
                inserted == True
                break

            # Change firstName
            elif (sDecision == "2"):
                new_fName = input("Please enter the student's new first name: ")
                cursor.execute(f"UPDATE Student SET fName = '{new_fName}' WHERE sID = {target_sID}")
                connection.commit()
                inserted == True
                break

            # Change lastName
            elif (sDecision == "3"):
                new_lName = input("Please enter the student's new last name: ")
                cursor.execute(f"UPDATE Student SET lName = '{new_lName}' WHERE sID = {target_sID}")
                connection.commit()
                inserted == True
                break

            # Change Major
            elif (sDecision == "4"):
                new_major = input("Please enter the student's new major: ")
                cursor.execute(f"UPDATE Student SET major = '{new_major}' WHERE sID = {target_sID}")
                connection.commit()
                inserted == True
                break

            # If input wasn't any of those options
            else:
                print("Invalid input. Try again.\n")

            # Reflect changes onto database
            connection.commit()


def viewCourses(cursor):
    """
    Purpose: Print out all available courses in the Course database
    Parameters: cursor - middleware between the database and the application
    Pre: None
    Post: List of all courses gets printed out
    Return: None
    Raise: None
    """

    print("You entered 5. See all the courses \n")

    # Print out all existing courses from the database
    cursor.execute("SELECT * FROM Course")
    rows = cursor.fetchall()
    for row in rows:
        print(row)

def studentEnrollment(cursor):
    """
    Purpose: View all classes a student is currently enrolled in
    Parameters: cursor - middleware between the database and the application
    Pre: Student must exist in the database
    Post: All courses the student is enrolled in gets printed
    Return: None
    Raise: Error if User tries to enter anything else other than integer for target_sID
    """

    print("You entered 6. See a student's enrollments \n")

    # Enter target studentID
    target_sID = int(input("Enter the student's ID whose record you want to update: "))
    cursor.execute(f"SELECT * FROM Student WHERE sID = {target_sID}")
    row = cursor.fetchall()

    # If student could not be verified
    if len(row) == 0:
        print("Student ID Invalid. Try again ")

    # Retrieve all enrollments that are under the studentID
    else:
        cursor.execute(f"SELECT * FROM Enrollment WHERE sID = {target_sID}")
        rows = cursor.fetchall()
        for row in rows:
            print(row)

def classEnrollment(cursor):
    """
    Purpose: View the total enrollment of a course
    Parameters: cursor - middleware between the database and the application
    Pre: Course must exist in the database
    Post: Total enrollment of a course is printed
    Return: None
    Raise: Error if User tries to enter anything else other than integer for target_cID
    """

    print("You entered 7. See how many students are enrolled in a course \n")

    # Enter the target courseID
    target_cID = int(input("Enter the student's ID whose record you want to update: "))
    cursor.execute(f"SELECT * FROM Enrollment WHERE cID = {target_cID}")
    eCount = cursor.fetchall()
            
    # If course could not be verified
    if len(eCount) == 0:
        print("Course ID Invalid. Try Again\n")

    # Print out course details and total number of enrollments
    else:
        cursor.execute(f"SELECT cID, title FROM Course WHERE cID = {target_cID}")
        selected = cursor.fetchall()
        for select in selected:
            print(f"{select}: {len(eCount)}\n")


def main():
    """
    Purpose: The main function that runs the University Database logic
    Parameters: None
    Pre: uni.py should be located in the same file as uni.db
    Post: University Database may be manipulated depending on the user
    Return: None
    Raise: None
    """

    # Connect to the University Database
    conn = sqlite3.connect('uni.db')
    cur = conn.cursor()

    # Decision Loop Runs until the User decides to Quit
    decision = ''
    while (decision != '8'):

        printIntroduction()

        loopEnd = False # Boolean Used for Asking the User to Continue

        decision = input("What is your decision? ") # Which option the User selects

        # Insert a Student
        if (decision == '1'):
            insertStudent(cur, conn)


        # Enroll a Student
        elif (decision == '2'):
            enrollStudent(cur, conn)
                   

        # Unenroll a Student
        elif (decision == '3'):
            unenrollStudent(cur, conn)
            

        # Update a Student Record
        elif (decision == '4'):
            updateRecord(cur, conn)
            

        # See all the courses
        elif (decision == '5'):
            viewCourses(cur)


        # See a student's enrollments
        elif (decision == '6'):
            studentEnrollment(cur)


        # See how many students are enrolled in a course
        elif (decision == '7'):
            classEnrollment(cur)


        # Quit the application
        elif (decision == '8'):
            break

        # If user enters an input that is not any of the above options
        else:
            print("Invalid entry. Try again.\n")

        # Check if the User wants to continue the application
        while (loopEnd == False):
            print("\nPress 1 to return to the main menu")
            print("Press 2 to exit")
            choice = input("What choice will you make: ")

            if (choice == '2'):
                decision = '8'
                loopEnd = True

            elif (choice == '1'):
                print("Returning to main menu!\n")
                loopEnd = True

            else:
                print("Invalid selection. Try again\n")

    # Exit the program and close off database access
    print("\nYou have exited the Cool University Database. Have a nice day!")
    conn.close()
        

# Logic that runs when file is executed
if __name__ == '__main__':
    main()
