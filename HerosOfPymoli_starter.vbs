# Dependencies and Setup
import pandas as pd

# File to Load (Remember to Change These)
file_to_load = "Resources/purchase_data.csv"

# Read Purchasing File and store into Pandas data frame
df = pd.read_csv(file_to_load)
df.head()

# Player Count
# Display the total number of players
total_players = df["SN"].nunique()
pd.DataFrame({'Total Players': [total_players]})

# Purchasing Analysis (Total)
# Run basic calculations to obtain number of unique items, average price, etc.
# Create a summary data frame to hold the results
# Optional: give the displayed data cleaner formatting
# Display the summary data frame

unique_items = df["Item ID"].nunique()
average_price = df["Price"].mean()
number_of_purchases = df["Purchase ID"].count()
total_revenue = df["Price"].sum()
pd.DataFrame(
    {'Number of Unique Items': [unique_items],
    'Average Price': [average_price],
    'Number of Purchases': [number_of_purchases],
    'Total Revenue': [total_revenue]}        
            
             )
new_df = pd.DataFrame(
    {'Number of Unique Items': [unique_items],
    'Average Price': [average_price],
    'Number of Purchases': [number_of_purchases],
    'Total Revenue': [total_revenue]}
             )
new_df['Average Price'] = new_df['Average Price'].map("${:.2f}".format)
new_df['Total Revenue'] = new_df['Total Revenue'].map("${:,.2f}".format)
new_df

# Gender Demographics
# Percentage and Count of Male Players
# Percentage and Count of Female Players
# Percentage and Count of Other / Non-Disclosed

gender_groups = df.groupby(["Gender"])
gender_percent = ((gender_groups["SN"].nunique() / total_players) * 100)

gender_df = pd.DataFrame({
    'Total Count': gender_groups["SN"].nunique(),
    'Percentage of Players': gender_percent
    })
gender_df = gender_df.sort_values("Total Count", ascending=False) 
gender_df

# Purchasing Analysis (Gender)
# Run basic calculations to obtain purchase count, avg. purchase price, avg. purchase total per person etc. by gender
# Create a summary data frame to hold the results
# Optional: give the displayed data cleaner formatting
# Display the summary data frame

gender_groupby = df.groupby(["Gender"])
gender_purchase_count = gender_groupby['Price'].count()
gender_average_price = gender_groupby['Price'].mean()
gender_total_value = gender_groupby['Price'].sum()
gender_total_ppp = gender_total_value / gender_groups["SN"].nunique()

gender_purchase_df = pd.DataFrame(
    {'Purchase Count': gender_purchase_count,
    'Average Purchase Price': gender_average_price,
    'Total Purchase Value': gender_total_value,
    'Avg Total Purchase per Person': gender_total_ppp
    })

new_gp_df = pd.DataFrame(
    {'Purchase Count': gender_purchase_count,
    'Average Purchase Price': gender_average_price,
    'Total Purchase Value': gender_total_value,
    'Avg Total Purchase per Person': gender_total_ppp
    })
gender_purchase_df

new_gp_df['Average Purchase Price'] = new_gp_df['Average Purchase Price'].map("${:.2f}".format)
new_gp_df['Total Purchase Value'] = new_gp_df['Total Purchase Value'].map("${:,.2f}".format)
new_gp_df['Avg Total Purchase per Person'] = new_gp_df['Avg Total Purchase per Person'].map("${:.2f}".format)
new_gp_df

# Age Demographics
# Establish bins for ages
# Categorize the existing players using the age bins. Hint: use pd.cut()
# Calculate the numbers and percentages by age group
# Create a summary data frame to hold the results
# Optional: round the percentage column to two decimal points
# Display Age Demographics Table

bins = [0, 9.99, 14.99, 19.99, 24.99, 29.99, 34.99, 39.99, 1000]
age_labels = ["<10", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40+"]

pd.cut(df['Age'], bins, labels=age_labels)
df["Age Group"] = pd.cut(df['Age'], bins, labels=age_labels)
age_groups = df.groupby(["Age Group"])
age_demo_total = age_groups["SN"].nunique()
age_demo_percentage = age_demo_total / total_players * 100
age_demo_df=pd.DataFrame({
    'Total Count': age_demo_total,
    'Percentage of Players': age_demo_percentage
    })

age_demo_df
age_df = pd.DataFrame({"Total Count": age_demo_total, "Percent of Players": age_demo_percentage})
age_df["Percent of Players"] = age_df["Percent of Players"].map("{:.2f}%".format)
age_df = age_df.sort_index()
age_df

# Purchasing Analysis (Age)
# Bin the purchase_data data frame by age
# Run basic calculations to obtain purchase count, avg. purchase price, avg. purchase total per person etc. in the table below
# Create a summary data frame to hold the results
# Optional: give the displayed data cleaner formatting
# Display the summary data frame

bins = [0, 9.99, 14.99, 19.99, 24.99, 29.99, 34.99, 39.99, 1000]
age_labels = ["<10", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40+"]

pd.cut(df['Age'], bins, labels=age_labels)

df["Age Group"] = pd.cut(df['Age'], bins, labels=age_labels)
age_groups = df.groupby("Age Group")
age_df = df.groupby("Age Group")
purchase_count = age_df["Purchase ID"].count()
avg_purchase_price = age_df["Price"].mean()
tot_purchase_value = age_df["Price"].sum()
avg_ppp = tot_purchase_value / age_demo_total
avg_ppp

pur_analysis = pd.DataFrame({
    'Purchase Count': purchase_count,
    'Average Purchase Price': avg_purchase_price,
    'Total Purchase Value': tot_purchase_value,
    'Avg Total Purchase Per Person': avg_ppp
})
pur_analysis

pur_df = pd.DataFrame({
    'Purchase Count': purchase_count,
    'Average Purchase Price': avg_purchase_price,
    'Total Purchase Value': tot_purchase_value,
    'Avg Total Purchase Per Person': avg_ppp
})

pur_df['Average Purchase Price'] = pur_df['Average Purchase Price'].map("${:.2f}".format)
pur_df['Total Purchase Value'] =  pur_df['Total Purchase Value'].map("${:,.2f}".format)
pur_df['Avg Total Purchase Per Person'] = pur_df['Avg Total Purchase Per Person'].map("${:.2f}".format)
pur_df

# Top Spenders
# Run basic calculations to obtain the results in the table below
# Create a summary data frame to hold the results
# Sort the total purchase value column in descending order
# Optional: give the displayed data cleaner formatting
# Display a preview of the summary data frame


ts_df = df.groupby("SN")
ts_df.head()
pur_count = ts_df["Purchase ID"].count()
avg_pur_price = ts_df["Price"].mean()
tot_pur_value = ts_df["Price"].sum()

top_spenders = pd.DataFrame({'Purchase Count': pur_count,
                      'Average Purchase Price': avg_pur_price,
                      'Total Purchase Value': tot_pur_value})

top_spenders = top_spenders.sort_values('Total Purchase Value', ascending=False) 
top_spenders

new_ts_df = pd.DataFrame({'Purchase Count': pur_count,
                      'Average Purchase Price': avg_pur_price,
                      'Total Purchase Value': tot_pur_value})
new_ts_df['Average Purchase Price'] = new_ts_df['Average Purchase Price'].map("${:.2f}".format)
new_ts_df['Total Purchase Value'] = new_ts_df['Total Purchase Value'].map("${:.2f}".format)
new_ts_df = new_ts_df.sort_values('Total Purchase Value', ascending=False) 
new_ts_df.head()


# Most Popular Items
# Retrieve the Item ID, Item Name, and Item Price columns
# Group by Item ID and Item Name. Perform calculations to obtain purchase count, item price, and total purchase value
# Create a summary data frame to hold the results
# Sort the purchase count column in descending order
# Optional: give the displayed data cleaner formatting
# Display a preview of the summary data frame

items = df[["Item ID", "Item Name", "Price"]]
items
mpi_df = items.groupby(["Item ID", "Item Name"])
mpi_pur_count = mpi_df['Item ID'].count()
mpi_price = mpi_df['Price'].mean()
mpi_total_pur_value = mpi_df['Price'].sum()

most_pop_items = pd.DataFrame({'Purchase Count': mpi_pur_count,
                             'Item Price': mpi_price,
                             'Total Purchase Value': mpi_total_pur_value
                              })
most_pop_items.head()

new_mpi_df = pd.DataFrame({'Purchase Count': mpi_pur_count,
                             'Item Price': mpi_price,
                             'Total Purchase Value': mpi_total_pur_value
                              })

new_mpi_df['Item Price'].map("${:.2f}".format)
new_mpi_df['Total Purchase Value'].map("${:.2f}".format)
new_mpi_df = most_pop_items.sort_values('Purchase Count', ascending=False)
new_mpi_df.head()

# Most Profitable Items
# Sort the above table by total purchase value in descending order
# Optional: give the displayed data cleaner formatting
# Display a preview of the data frame

items = df[["Item ID", "Item Name", "Price"]]
items
mpi_df = items.groupby(["Item ID", "Item Name"])
mpi_pur_count = mpi_df['Item ID'].count()
mpi_price = mpi_df['Price'].mean()
mpi_total_pur_value = mpi_df['Price'].sum()

most_pop_items = pd.DataFrame({'Purchase Count': mpi_pur_count,
                             'Item Price': mpi_price,
                             'Total Purchase Value': mpi_total_pur_value
                              })
most_pop_items.head()

new_mpi_df = pd.DataFrame({'Purchase Count': mpi_pur_count,
                             'Item Price': mpi_price,
                             'Total Purchase Value': mpi_total_pur_value
                              })

new_mpi_df['Item Price'].map("${:,.2f}".format)
new_mpi_df['Total Purchase Value'].map("${:,.2f}".format)
new_mpi_df = most_pop_items.sort_values('Purchase Count', ascending=False)
new_mpi_df.head()

# Most Profitable Items
# Sort the above table by total purchase value in descending order
# Optional: give the displayed data cleaner formatting
# Display a preview of the data frame

new_mpi_df = most_pop_items.sort_values('Total Purchase Value', ascending=False)
new_mpi_df.head()