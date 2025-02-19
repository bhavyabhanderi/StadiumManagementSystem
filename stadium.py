import mysql.connector
from datetime import datetime
import random
import matplotlib.pyplot as plt

class Get:
    def get_date_time(self):
        now = datetime.now()
        return f"Date - {now.strftime('%d/%m/%Y')}      Time - {now.strftime('%H:%M:%S')}"

class Match:
    def __init__(self, match_id, match, match_date, match_time):
        self.match_id = match_id
        self.match = match
        self.match_date = match_date
        self.match_time = match_time

    def __str__(self):
        return f"id : {self.match_id}               Match : {self.match}\nMatch Date : {self.match_date}      Match Time : {self.match_time}\n"
class Staff:
    def login_staff(self, con):
        print("------ Welcome to Staff Login Page ------")
        staff_id = int(input("Enter Staff id : "))
        cursor = con.cursor()
        cursor.execute("SELECT password FROM staff WHERE staff_id=%s", (staff_id,))
        result = cursor.fetchone()

        if result:
            password = input("Enter Password : ")
            if result[0] == password:
                print("----- Login Successful -----")
                self.staff_work_page(con)
            else:
                print("Password Not Matched. Login Failed")
        else:
            print("Staff Id Not Found")

    def staff_work_page(self, con):
        choice = 0
        while choice != 8:  
            print("\n========= Staff Work Page =========")
            print("1. Add Match")
            print("2. Remove Match")
            print("3. Get Last Booked Ticket Details")
            print("4. Get Match Detail By Match id")
            print("5. Get User Detail By User id")
            print("6. Show Match Ticket Booking Data")
            print("7. Show Food Order Data")  
            print("8. Go To Home Page")
            choice = int(input("Enter Choice : "))

            if choice == 1:
                self.add_match(con)
            elif choice == 2:
                self.remove_match(con)
            elif choice == 3:
                self.get_last_booked_ticket(con)
            elif choice == 4:
                self.get_match_detail(con)
            elif choice == 5:
                self.get_user_detail(con)
            elif choice == 6:
                self.show_ticket_booking_data(con)
            elif choice == 7:
                self.show_food_order_data(con)  
            elif choice == 8:
                break
            else:
                print("Invalid Choice, Enter Valid Choice")

    def show_food_order_data(self, con):
        try:
            cursor = con.cursor()
            cursor.execute("""
                SELECT food_item, SUM(quantity) AS total_quantity
                FROM food_orders
                GROUP BY food_item
                ORDER BY total_quantity DESC
            """)
            data = cursor.fetchall()

            if data:
                food_items = [row[0] for row in data]
                quantities = [row[1] for row in data]

                # Plotting the bar chart
                plt.figure(figsize=(10, 6))
                plt.bar(food_items, quantities, color='orange')
                plt.title('Most Popular Food Items', fontsize=16)
                plt.xlabel('Food Items', fontsize=14)
                plt.ylabel('Total Quantity Ordered', fontsize=14)
                plt.xticks(rotation=45, ha='right')
                plt.tight_layout()
                plt.show()
            else:
                print("No food order data found.")
        except Exception as e:
            print(f"An error occurred while showing food order data: {e}")
            
    def show_ticket_booking_data(self, con):
        try:
            cursor = con.cursor()
            cursor.execute("""
                SELECT m.match_name, COUNT(t.ticket_id) AS ticket_count
                FROM matches m
                LEFT JOIN ticket t ON m.match_id = t.match_id
                GROUP BY m.match_id
                ORDER BY ticket_count DESC
            """)
            data = cursor.fetchall()

            if data:
                match_names = [row[0] for row in data]
                ticket_counts = [row[1] for row in data]

                # Plotting the bar chart
                plt.figure(figsize=(10, 6))
                plt.bar(match_names, ticket_counts, color='skyblue')
                plt.title('Match Ticket Bookings', fontsize=16)
                plt.xlabel('Matches', fontsize=14)
                plt.ylabel('Number of Tickets Booked', fontsize=14)
                plt.xticks(rotation=45, ha='right')
                plt.tight_layout()
                plt.show()
            else:
                print("No match ticket booking data found.")
        except Exception as e:
            print(f"An error occurred while showing ticket booking data: {e}")



    def add_match(self, con):
        match_name = input("Enter Match Name : ")
        match_id = int(input("Enter Match Id : "))
        series_name = input("Enter Series or Tournament Name : ")
        match_format = input("Enter Match Format : ")
        match_date = input("Enter Match Date (dd/mm/yyyy) : ")
        match_time = input("Enter Match Time (hh:mm:ss) : ")

        cursor = con.cursor()
        sql = "INSERT INTO matches(match_id, match_name, series_tournament_name, match_format, match_date, match_time) VALUES (%s, %s, %s, %s, %s, %s)"
        cursor.execute(sql, (match_id, match_name, series_name, match_format, match_date, match_time))
        con.commit()
        print("------- Match Added Successfully -------")

    def remove_match(self, con):
        match_id = int(input("Enter Match Id To Remove Match : "))
        cursor = con.cursor()
        cursor.callproc('delete_match', (match_id,))
        con.commit()
        print(f"----- Match Deleted Successfully For Match id = {match_id} -----")

    def get_last_booked_ticket(self, con):
        cursor = con.cursor()
        cursor.execute("SELECT * FROM ticket ORDER BY ticket_id DESC LIMIT 1")
        ticket = cursor.fetchone()
        if ticket:
            print("----- Last Ticket Details -----")
            print(f"Ticket ID : {ticket[0]}\nMatch ID : {ticket[1]}\nUser  ID : {ticket[2]}\nStand Name : {ticket[3]}\nTicket Price : {ticket[4]}\nNo. Of Tickets Booked : {ticket[5]}\nTotal Payment : {ticket[6]}\nPayment Method : {ticket[7]}")
        else:
            print("No Tickets Found")

    def get_match_detail(self, con):
        match_id = int(input("Enter Match id To Print Match Details : "))
        cursor = con.cursor()
        cursor.execute("SELECT * FROM matches WHERE match_id=%s", (match_id,))
        match = cursor.fetchone()
        if match:
            print("------ Match Details ------")
            print(f"Match Id : {match[0]}\nMatch Name : {match[1]}\nSeries/Tournament Name : {match[2]}\nMatch Format : {match[3]}\nMatch Date : {match[4]}\nMatch Time : {match[5]}")
        else:
            print("Match Not Found")

    def get_user_detail(self, con):
        user_id = int(input("Enter User id To Print User Details : "))
        cursor = con.cursor()
        cursor.execute("SELECT * FROM user WHERE user_id=%s", (user_id,))
        user = cursor.fetchone()
        if user:
            print("------ User Details ------")
            print(f"User  Id : {user[0]}\nName : {user[1]}\nMobile No. : {user[3]}")
        else:
            print("User  Not Found")
class User:
    def __init__(self, name, user_id, password, mobile):
        self.name = name
        self.user_id = user_id
        self.password = password
        self.mobile = mobile

class SetUser :
    def __init__(self):
        self.sc = None
        self.g = Get()

    def new_user(self, con):
        print("----- Welcome To Registration Page -----")
        name = input("Enter User Name : ")
        user_id = int(input("Enter UserId : "))
        password = input("Enter Password : ")
        mobile = input("Enter Mobile no. : ")

        if len(mobile) == 10 and mobile.isdigit():
            try:
                cursor = con.cursor()
                sql = "INSERT INTO user(user_id, user_name, password, mobile_no) VALUES (%s, %s, %s, %s)"
                cursor.execute(sql, (user_id, name, password, mobile))
                con.commit()

                date_time = self.g.get_date_time()
                with open(f"{mobile}.txt", "w+") as f:
                    f.write(date_time + "\n")
                    f.write("1 new Message : \n")
                    f.write("     Your Mobile No. Registered At Narendra Modi Cricket Stadium Web.\n")

                print("------- Registration Success -------")
            except mysql.connector.IntegrityError:
                print("Registration Failed")
                print("User  ID Already exists, Please Register With Different User ID")
        else:
            print("Invalid Mobile No., Registration Failed")

    def change_password(self, con):
        user_id = int(input("Enter UserId : "))
        cursor = con.cursor()
        cursor.execute("SELECT password FROM user WHERE user_id=%s", (user_id,))
        old_pass = cursor.fetchone()

        if old_pass:
            old_pass = old_pass[0]
            password = input("Enter Old Password : ")
            if password == old_pass:
                new_pass = input("Enter New Password : ")
                cursor.execute("UPDATE user SET password = %s WHERE user_id = %s", (new_pass, user_id))
                con.commit()
                print("------ Password Changed Successfully ------")
            else:
                print("Password Not Matched, Password Changing Failed")
        else:
            print("No User Id Found")

    def delete_user(self, con, user_id):
        cursor = con.cursor()
        cursor.execute("SELECT mobile_no FROM user WHERE user_id=%s", (user_id,))
        mobile = cursor.fetchone()

        if mobile:
            mobile = mobile[0]
            otp = random.randint(100000, 999999)
            with open(f"{mobile}.txt", "a") as f:
                f.write(f"\n{self.g.get_date_time()}\n1 new Message : \n   Your OTP for Delete User is {otp}\n")
            print(f"OTP sent to Your Registered Mobile No. {mobile}")

            for attempt in range(3):
                f_otp = int(input("Enter OTP here : "))
                if otp == f_otp:
                    cursor.callproc('delete_user', (user_id,))
                    con.commit()
                    print("----- User Deleted Successfully -----")
                    return
                else:
                    print(f"Invalid OTP, Attempt left: {2 - attempt}")
            print("User  Deletion Failed")
        else:
            print("User  Not Found")


class LoginedUser:
    def __init__(self):
        self.sc = None
        self.g = Get()
        

    def login_user(self, con):
        print("------ Welcome to User Login Page ------")
        user_id = int(input("Enter User id : "))
        cursor = con.cursor()
        cursor.execute("SELECT password FROM user WHERE user_id=%s", (user_id,))
        result = cursor.fetchone()

        if result:
            password = input("Enter Password : ")
            if result[0] == password:
                print("----- Login Successful -----")
                self.logined_user(con, user_id)
            else:
                print("Password Not Matched. Login Failed")
        else:
            print("User Id Not Found")

    def logined_user(self, con, user_id):
        ticket = Ticket()
        set_user = SetUser()
        choice = 0
        while choice != 8:  
            print("-------- Welcome to User Page --------")
            print("1. Book Ticket")
            print("2. Order Food") 
            print("3. Show Tickets Availability for All Matches")
            print("4. SMS Tickets to Your Mobile No.")
            print("5. Get Matches Details")
            print("6. Change Password")
            print("7. Delete Account")
            print("8. Go To Home Page")
            choice = int(input("Enter Choice : "))

            if choice == 1:
                ticket.book_ticket(con, user_id)
            elif choice == 2:
                self.order_food(con, user_id)  
            elif choice == 3:
                self.show_tickets_availability(con)
            elif choice == 4:
                ticket.sms_ticket(con, user_id)
            elif choice == 5:
                self.get_match(con)
            elif choice == 6:
                set_user.change_password(con)
            elif choice == 7:
                set_user.delete_user(con, user_id)
            elif choice == 8:
                break
            else:
                print("Enter Valid Choice From 1 to 8")

    def order_food(self, con, user_id):
        print("------ Welcome to Food Ordering ------")
        match_ids = self.get_match(con)
        match_id = int(input("Enter Match ID for which you want to order food: "))

        if match_id in match_ids:
            food_menu = {
                1: ("Burger", 150),
                2: ("Pizza", 300),
                3: ("Hot Dog", 100),
                4: ("Popcorn", 80),
                5: ("Soft Drink", 50),
            }

            print("------ Food Menu ------")
            for key, value in food_menu.items():
                print(f"{key}. {value[0]} - ₹{value[1]}")

            food_choice = int(input("Enter the number of the food item you want to order: "))
            if food_choice in food_menu:
                food_item, price = food_menu[food_choice]
                quantity = int(input(f"Enter the quantity of {food_item}: "))
                total_price = price * quantity
                print(f"Total Bill : {total_price}")
                payment_method = self.get_payment_method()
                mobile = self.get_user_mobile(con, user_id)
                otp = random.randint(100000, 999999)
                self.send_otp(mobile, total_price, otp)

                if self.confirm_payment(otp):
                    cursor = con.cursor()
                    sql = """
                    INSERT INTO food_orders (user_id, match_id, food_item, quantity, total_price, order_date)
                    VALUES (%s, %s, %s, %s, %s, %s)
                    """
                    order_date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                    cursor.execute(sql, (user_id, match_id, food_item, quantity, total_price, order_date))
                    con.commit()
                    print(f"Order placed successfully! Total amount: ₹{total_price}")
                else:
                    print("Payment Cancelled")
            else:
                print("Invalid food choice.")
        else:
            print("Invalid Match ID.")
    def get_payment_method(self):
        print("-- Available Payment Methods --")
        print("1. UPI")
        print("2. Debit Card")
        print("3. Credit Card")
        print("4. Netbanking")
        pm_no = int(input("Enter Your Payment Method No. : "))
        methods = {1: "UPI", 2: "Debit Card", 3: "Credit Card", 4: "Netbanking"}
        return methods.get(pm_no, "Unknown")

    def get_user_mobile(self, con, user_id):
        cursor = con.cursor()
        cursor.execute("SELECT mobile_no FROM user WHERE user_id=%s", (user_id,))
        return cursor.fetchone()[0]

    def send_otp(self, mobile, total_payments, otp):
        with open(f"{mobile}.txt", "a") as f:
            f.write(f"\n{self.g.get_date_time()}\n1 new Message : \n   Total Payment For Food Order is {total_payments} Rs.\n")
            f.write(f"   Your OTP for Payment Confirmation is {otp}\n")
        print(f" OTP sent to Your Registered Mobile No. {mobile}")

    def confirm_payment(self, otp):
        for attempt in range(3):
            f_otp = int(input("Enter OTP To Confirm Your Payment : "))
            if otp == f_otp:
                print("Payment Confirmed !!!")
                return True
            else:
                print(f"Invalid OTP, Attempt left: {2 - attempt}")
        return False

    def get_match(self, con):
        cursor = con.cursor()
        cursor.execute("SELECT * FROM matches")
        matches = cursor.fetchall()
        print("------- Available Matches -------")
        for match in matches:
            match_obj = Match(match[0], match[1], match[4], match[5])
            print(match_obj)
        return [match[0] for match in matches]

    def show_tickets_availability(self, con):
        try:
            cursor = con.cursor()
            cursor.execute("""
                SELECT m.match_name, 
                       (m.total_tickets - COALESCE(SUM(t.no_of_tickets), 0)) AS available_tickets
                FROM matches m
                LEFT JOIN ticket t ON m.match_id = t.match_id
                GROUP BY m.match_id
                ORDER BY available_tickets DESC
            """)
            data = cursor.fetchall()

            if data:
                match_names = [row[0] for row in data]
                available_tickets = [row[1] for row in data]

                # Plotting the bar chart
                plt.figure(figsize=(10, 6))
                plt.bar(match_names, available_tickets, color='lightgreen')
                plt.title('Available Tickets for Matches', fontsize=16)
                plt.xlabel('Matches', fontsize=14)
                plt.ylabel('Available Tickets', fontsize=14)
                plt.xticks(rotation=45, ha='right')
                plt.tight_layout()
                plt.show()
            else:
                print("No matches found.")
        except Exception as e:
            print(f"An error occurred while showing ticket availability: {e}")


class Ticket:
    def __init__(self):
        self.sc = None
        self.g = Get()

    def book_ticket(self, con, user_id):
        logined_user = LoginedUser()
        match_ids = logined_user.get_match(con)
        match_id = int(input("Enter Match Id From Above Match Details : "))

        if match_id in match_ids:
            print("  Stand_No.  |  Stand  |  Seat_Price  ")
            print("     1       |    A    |     1500     ")
            print("     2       |    B    |     1200     ")
            print("     3       |    C    |     1800     ")
            print("     4       |    D    |     2000     ")
            stand_no = int(input("Enter Stand No. From Table : "))
            stand, ticket_price = self.get_stand_details(stand_no)

            no_of_tickets = int(input("Enter No. Of Tickets You Want To Buy : "))
            cursor = con.cursor()
            cursor.execute("""
            SELECT (m.total_ticket - COALESCE(SUM(t.no_of_tickets), 0)) AS available_tickets
            FROM matches m
            LEFT JOIN ticket t ON m.match_id = t.match_id
            WHERE m.match_id = %s
            GROUP BY m.match_id""", (match_id,))

            available_tickets = cursor.fetchone()[0]

            if no_of_tickets <= available_tickets:
                total_payments = ticket_price * no_of_tickets
                print(f"Total Bill : {total_payments}")

                payment_method = self.get_payment_method()
                mobile = self.get_user_mobile(con, user_id)
                otp = random.randint(100000, 999999)
                self.send_otp(mobile, total_payments, otp)

                if self.confirm_payment(otp):
                    self.save_ticket(con, match_id, user_id, stand, ticket_price, no_of_tickets, total_payments, payment_method)
                else:
                    print("Payment Cancelled")
            else:
                print(f"Insufficient tickets available. Only {available_tickets} tickets are available for this match.")
        else:
            print("Match Id Not Found, Redirecting To User Page.")

    def get_stand_details(self, stand_no):
        if stand_no == 1:
            return "A", 1000
        elif stand_no == 2:
            return "B", 2000
        elif stand_no == 3:
            return "C", 5000
        elif stand_no == 4:
            return "D", 10000
        else:
            print("Invalid Stand No.")
            return None, 0

    def get_payment_method(self):
        print("-- Available Payment Methods --")
        print("1. UPI")
        print("2. Debit Card")
        print("3. Credit Card")
        print("4. Netbanking")
        pm_no = int(input("Enter Your Payment Method No. : "))
        methods = {1: "UPI", 2: "Debit Card", 3: "Credit Card", 4: "Netbanking"}
        return methods.get(pm_no, "Unknown")

    def get_user_mobile(self, con, user_id):
        cursor = con.cursor()
        cursor.execute("SELECT mobile_no FROM user WHERE user_id=%s", (user_id,))
        return cursor.fetchone()[0]

    def send_otp(self, mobile, total_payments, otp):
        with open(f"{mobile}.txt", "a") as f:
            f.write(f"\n{self.g.get_date_time()}\n1 new Message : \n   Total Payment For Book Ticket is {total_payments} Rs.\n")
            f.write(f"   Your OTP for Payment Confirmation is {otp}\n")
        print(f" OTP sent to Your Registered Mobile No. {mobile}")

    def confirm_payment(self, otp):
        for attempt in range(3):
            f_otp = int(input("Enter OTP To Confirm Your Payment : "))
            if otp == f_otp:
                print("Payment Confirmed !!!")
                return True
            else:
                print(f"Invalid OTP, Attempt left: {2 - attempt}")
        return False

    def save_ticket(self, con, match_id, user_id, stand, ticket_price, no_of_tickets, total_payments, payment_method):
        cursor = con.cursor()
        sql = "INSERT INTO ticket(match_id, user_id, stand, ticket_price, no_of_tickets, total_payments, payment_method) VALUES (%s, %s, %s, %s, %s, %s, %s)"
        cursor.execute(sql, (match_id, user_id, stand, ticket_price, no_of_tickets, total_payments, payment_method))
        con.commit()
        print("Tickets Booked Successfully!")

    def sms_ticket(self, con, user_id):
        cursor = con.cursor()
        cursor.execute("SELECT * FROM ticket WHERE user_id=%s", (user_id,))
        tickets = cursor.fetchall()

        if tickets:
            for ticket in tickets:
                match_id = ticket[1]
                ticket_id = ticket[0]
                stand = ticket[3]
                ticket_price = ticket[4]
                booked_tickets = ticket[5]
                total_paid = ticket[6]
                payment_method = ticket[7]

                cursor.execute("SELECT user_name, mobile_no FROM user WHERE user_id=%s", (user_id,))
                user = cursor.fetchone()
                user_name = user[0]
                mobile = user[1]

                cursor.execute("SELECT match_name, match_date, match_time FROM matches WHERE match_id=%s", (match_id,))
                match = cursor.fetchone()
                match_name = match[0]
                match_date = match[1]
                match_time = match[2]

                with open(f"{mobile}.txt", "a") as f:
                    f.write(f"\n{self.g.get_date_time()}\n1 new Message : \n   From Narendar Modi Stadium Web : \n       TICKET'S DETAILS  \n")
                    f.write(f"   Ticket ID : {ticket_id}\n   Ticket Booked By : {user_name}\n   Match Name : {match_name}\n")
                    f.write(f"   Match Date : {match_date}\n   Match Time : {match_time}\n   Stand Name : {stand}\n")
                    f.write(f"   Ticket Price : {ticket_price}\n   Booked Tickets : {booked_tickets}\n   Total Amount Paid : {total_paid}\n   Method Of Payment : {payment_method}\n")
                print(f"Tickets Details Sent Successfully to Mobile No. : {mobile}")
        else:
            print(f"Not Any Tickets Booked By You, User ID : {user_id}")

class Stadium:
    def main(self):
        db_url = "localhost"
        db_user = "root"
        db_pass = ""
        db_name = "s"

        con = mysql.connector.connect(user=db_user, password=db_pass, host=db_url, database=db_name)
        if con.is_connected():
            print("==========================================================")
            print("====== Welcome To Narendra Modi Cricket Stadium Web ======")
            print("==========================================================")
            while True:
                print("\n======= Welcome To Home Page =======")
                print("1. For Staff Login.")
                print("2. For User Registration.")
                print("3. For User Login.")
                print("4. EXIT")
                choice = int(input("Enter Choice : "))

                if choice == 1:
                    staff = Staff()
                    staff.login_staff(con)
                elif choice == 2:
                    set_user = SetUser ()
                    set_user.new_user(con)
                elif choice == 3:
                    logined_user = LoginedUser ()
                    logined_user.login_user(con)
                elif choice == 4:
                    print("----- Thank You For Visit -----")
                    break
                else:
                    print("Invalid Choice, Enter Valid Choice")
        con.close()
        
if __name__ == "__main__":
    stadium = Stadium()
    stadium.main()