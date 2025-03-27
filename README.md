# PetPals - The Pet Adoption System

## Database Structure 
The system comprises the following tables:  

### 1. Pets 
- **PetID** (Primary Key, INT): Unique identifier assigned to each pet.  
- **Name** (VARCHAR): Name of the pet.  
- **Age** (INT): Age of the pet in years.  
- **Breed** (VARCHAR): Breed classification of the pet.  
- **Type** (VARCHAR): Specifies the type of pet (e.g., Dog, Cat).  
- **AvailableForAdoption** (BIT): Indicates adoption status (0 for unavailable, 1 for available).  

### 2. Shelters
- **ShelterID** (Primary Key, INT): Unique identifier for each shelter.  
- **Name** (VARCHAR): Name of the shelter.  
- **Location** (VARCHAR): Geographical location of the shelter.  

### **3. Donations**  
- **DonationID** (Primary Key, INT): Unique identifier for each donation.  
- **DonorName** (VARCHAR): Name of the donor.  
- **DonationType** (VARCHAR): Specifies whether the donation is monetary or an item.  
- **DonationAmount** (DECIMAL): Amount donated (applicable to cash donations).  
- **DonationItem** (VARCHAR): Description of donated items (applicable to non-cash donations).  
- **DonationDate** (DATETIME): Timestamp of the donation.  

### **4. AdoptionEvents**  
- **EventID** (Primary Key, INT): Unique identifier assigned to each event.  
- **EventName** (VARCHAR): Name of the adoption event.  
- **EventDate** (DATETIME): Scheduled date and time of the event.  
- **Location** (VARCHAR): Venue where the event will be conducted.  

### **5. Participants**  
- **ParticipantID** (Primary Key, INT): Unique identifier for each participant.  
- **ParticipantName** (VARCHAR): Name of the participant.  
- **ParticipantType** (VARCHAR): Specifies if the participant is a shelter or an adopter.  
- **EventID** (Foreign Key, INT): References the **EventID** from the **AdoptionEvents** table.  

## **Features Implemented**  

### **1. Database Setup**  
- SQL script to initialize and configure the PetPals database.  
- Ensures proper handling of existing databases and tables.  

### **2. SQL Queries**  
- Fetch the list of pets currently available for adoption.  
- Retrieve participant names and categories for a particular adoption event.  
- Update shelter details through a stored procedure.  
- Compute the total donations received by each shelter.  
- Identify pets that do not have owners.  
- Determine the total donation amount per month and per year.  
- Retrieve unique pet breeds for those aged between 1-3 years or older than 5 years.  
- List pets along with their respective shelters where adoption is available.  
- Count total event participants in a given city.  
- Retrieve distinct breeds for pets aged between 1 and 5 years.  
- Identify pets that have not yet been adopted.  
- List adopted pets along with their adopters.  
- Display shelters along with the count of pets available for adoption.  
- Identify pairs of pets with the same breed from the same shelter.  
- Generate all possible combinations of shelters and adoption events.  
- Determine which shelter has the highest number of successful pet adoptions.  

## **Usage Instructions**  
- Clone the project repository and import the SQL script.  
- Execute the script to create tables and insert necessary data.  
- Use the provided SQL queries to interact with and retrieve relevant data.  

## **Execution Steps**  
1. Load the **petpals_sql.sql** file into your MySQL server.  
2. Execute the stored procedures and queries as needed to explore the database.
