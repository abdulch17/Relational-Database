#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

MAIN_MENU(){
  SERVICES=$($PSQL "SELECT * FROM services")
echo "$SERVICES" | while read ID BAR SERVICE 
do
echo "$ID) $SERVICE"
done
echo -e "\nPlease enter a service_id"
read SERVICE_ID_SELECTED
SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
if [[ -z $SERVICE_NAME ]]
then
echo -e "\nPlease enter a valid service id"
MAIN_MENU
fi
}
MAIN_MENU

echo -e "\nPlease enter your phone number."
read CUSTOMER_PHONE
CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
if [[ -z $CUSTOMER_NAME ]]
then
echo -e "\nPlease enter your name."
read CUSTOMER_NAME
INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
fi
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
echo -e "\nPlease enter a time"
read SERVICE_TIME
INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
echo I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME.




