# Monster Shop
BE Mod 2 Week 4/5 Group Project


## Background and Description

"Little Shop of Orders" is a fictitious e-commerce platform where users can register to place items into a shopping cart and 'check out'. Users who work for a merchant can mark their items as 'fulfilled'; the last merchant to mark items in an order as 'fulfilled' will automatically set the order status to "shipped". Each user role will have access to some or all CRUD functionality for application models.

Students will be put into 3 or 4 person groups to complete the project.\n

## Learning Goals

### Rails
* Create routes for namespaced routes
* Implement partials to break a page into reusable components
* Use Sessions to store information about a user and implement login/logout functionality
* Use filters (e.g. `before_action`) in a Rails controller
* Limit functionality to authorized users
* Use BCrypt to hash user passwords before storing in the database

### ActiveRecord
* Use built-in ActiveRecord methods to join multiple tables of data, calculate statistics and build collections of data grouped by one or more attributes

### Databases
* Design and diagram a Database Schema
* Write raw SQL queries (as a debugging tool for AR)

## Requirements

- must use Rails 5.1.x
- must use PostgreSQL
- must use 'bcrypt' for authentication
- all controller and model code must be tested via feature tests and model tests, respectively
- must use good GitHub branching, team code reviews via GitHub comments, and use of a project planning tool like waffle.io
- must include a thorough README to describe their project

## Permitted

- use FactoryBot to speed up your test development
- use "rails generators" to speed up your app development

## Not Permitted

- do not use JavaScript for pagination or sorting controls

## Permission

- if there is a specific gem you'd like to use in the project, please get permission from your instructors first

## User Roles

1. Visitor - this type of user is anonymously browsing our site and is not logged in
2. Registered User - this user is registered and logged in to the application while performing their work; can place items in a cart and create an order
- Registered Users may or may not work for a merchant, in addition to having their regular user role
3. Merchant Admin - this user works for a merchant, and has additional capabilities than regular employees
- A user will only be able to be a merchant admin, if they are employed by a merchant
3. Admin User - a registered user (but cannot also be a merchant) who has "superuser" access to all areas of the application; user is logged in to perform their work

In addition, some Registered users may work for a Merchant, these users will have additional capabilities - like fulfilling order items.

## Order Status

1. 'pending' means a user has placed items in a cart and "checked out" to create an order, merchants may or may not have fulfilled any items yet
2. 'packaged' means all merchants have fulfilled their items for the order, and has been packaged and ready to ship
3. 'shipped' means an admin has 'shipped' a package and can no longer be cancelled by a user
4. 'cancelled' - only 'pending' and 'packaged' orders can be cancelled


## Not Everything can be FULLY Deleted

In the user stories, we talk about "CRUD" functionality. However, it's rare in a real production system to ever truly delete content, and instead we typically just 'enable' or 'disable' content. Users, items and orders can be 'enabled' or 'disabled' which blocks functionality (users whose accounts are disabled should not be allowed to log in, items which are disabled cannot be ordered, orders which are disabled cannot be processed, and so on).

Disabled content should also be restricted from showing up in the statistics pages. For example: if an item is disabled, it should not appear in a list of "popular items".

Be careful to watch out for which stories allow full deletion of content, and restrictions on when they apply.

```
[ ] done

User Story 1, Deploy your application to Heroku

As a visitor or user of the site
I will perform all user stories
By visiting the application on Heroku.
Localhost is fine for development, but
the application must be hosted on Heroku.
```

---

## Navigation
This series of stories will set up a navigation bar at the top of the screen and present links and information to users of your site.

There is no requirement that the nav bar be "locked" to the top of the screen.

### Completion of these stories will encompass the following ideas:

- the navigation is built into app/views/layouts/application.html.erb or loaded into that file as a partial
- you write a single set of tests that simply click on a link and expect that your current path is what you expect to see
- your nav tests don't need to check any content on the pages, just that current_path is what you expect

You will need to set up some basic routing and empty controller actions and empty action view files.

```
[ ] done

User Story 2, Visitor Navigation

As a visitor
I see a navigation bar
This navigation bar includes links for the following:
- a link to return to the welcome / home page of the application ("/")
- a link to browse all items for sale ("/items")
- a link to see all merchants ("/merchants")
- a link to my shopping cart ("/cart")
- a link to log in ("/login")
- a link to the user registration page ("/register")

Next to the shopping cart link I see a count of the items in my cart
```

```
[ ] done

User Story 3, User Navigation

As a registered user
I see the same links as a visitor
Plus the following links
- a link to my profile page ("/profile")
- a link to log out ("/logout")

Minus the following links
- I do not see a link to log in or register

I also see text that says "Logged in as Ian Douglas" (or whatever my name is)
```

```
[ ] done

User Story 4, Merchant Navigation

As a user who works for a merchant
I see the same links as a visitor
Plus the following links:
- a link to my merchant dashboard ("/merchant")
- a link to log out ("/logout")

Minus the following links/info:
- I do not see a link to log in or register
```

```
[ ] done

User Story 5, Admin Navigation

As an admin user
I see the same links as a visitor
Plus the following links
- a link to my admin dashboard ("/admin")
- a link to log out ("/logout")
- a link to see all users ("/admin/users")

Minus the following links/info:
- I do not see a link to log in or register
- a link to my shopping cart ("/cart") or count of cart items
```

```
[ ] done

User Story 6, Visitor Navigation Restrictions

As a Visitor
When I try to access any path that begins with the following, then I see a 404 error:
- '/merchant'
- '/admin'
- '/profile'
```

```
[ ] done

User Story 7, User Navigation Restrictions

As a User
When I try to access any path that begins with the following, then I see a 404 error:
- '/merchant'
- '/admin'
```

```
[ ] done

User Story 8, Merchant Navigation Restrictions

As a Merchant
When I try to access any path that begins with the following, then I see a 404 error:
- '/profile'
- '/admin'
- '/cart'
```

```
[ ] done

User Story 9, Admin Navigation Restrictions

As a Admin
When I try to access any path that begins with the following, then I see a 404 error:
- '/profile'
- '/merchant'
- '/cart'
```

---

## User Registration
This series of stories will allow a user to register on the site.

```
[ ] done

User Story 10, User Registration

As a visitor
When I click on the 'register' link in the nav bar
Then I am on the user registration page ('/register')
And I see a form where I input the following data:
- my name
- my street address
- my city
- my state
- my zip code
- my email address
- my preferred password
- a confirmation field for my password

When I fill in this form completely,
And with a unique email address not already in the system
My details are saved in the database
Then I am logged in as a registered user
I am taken to my profile page ("/profile")
I see a flash message indicating that I am now registered and logged in
```

```
[ ] done

User Story 11, User Registration Missing Details

As a visitor
When I visit the user registration page
And I do not fill in this form completely,
I am returned to the registration page
And I see a flash message indicating that I am missing required fields
```

```
[ ] done

User Story 12, Registration Email must be unique

As a visitor
When I visit the user registration page
If I fill out the registration form
But include an email address already in the system
Then I am returned to the registration page
My details are not saved and I am not logged in
The form is filled in with all previous data except the email field and password fields
I see a flash message telling me the email address is already in use
```

---

## Login / Logout
Our application wouldn't be much use if users could not log in to use it.

```
[ ] done

User Story 13, User can Login

As a visitor
When I visit the login path
I see a field to enter my email address and password
When I submit valid information
If I am a regular user, I am redirected to my profile page
If I am a merchant user, I am redirected to my merchant dashboard page
If I am an admin user, I am redirected to my admin dashboard page
And I see a flash message that I am logged in
```

```
[ ] done

User Story 14, User cannot log in with bad credentials

As a visitor
When I visit the login page ("/login")
And I submit invalid information
Then I am redirected to the login page
And I see a flash message that tells me that my credentials were incorrect
I am NOT told whether it was my email or password that was incorrect
```

```
[ ] done

User Story 15, Users who are logged in already are redirected

As a registered user, merchant, or admin
When I visit the login path
If I am a regular user, I am redirected to my profile page
If I am a merchant user, I am redirected to my merchant dashboard page
If I am an admin user, I am redirected to my admin dashboard page
And I see a flash message that tells me I am already logged in
```

```
[ ] done

User Story 16, User can log out

As a registered user, merchant, or admin
When I visit the logout path
I am redirected to the welcome / home page of the site
And I see a flash message that indicates I am logged out
Any items I had in my shopping cart are deleted
```

---

## Items
This is the main "catalog" page of the entire site where users will start their e-commerce experience. Visitors to the site, and regular users, will be able to view an index page of all items available for purchase and some basic statistics. Each item will also have a "show" page where more information is shown.

```
[ ] done

User Story 17, Items Index Page

As any kind of user on the system
I can visit the items catalog ("/items")
I see all items in the system except disabled items

The item image is a link to that item's show page
```

```
[ ] done

User Story 18, Items Index Page Statistics

As any kind of user on the system
When I visit the items index page ("/items")
I see an area with statistics:
- the top 5 most popular items by quantity purchased, plus the quantity bought
- the bottom 5 least popular items, plus the quantity bought

"Popularity" is determined by total quantity of that item ordered
```

---

## User Profile Page
When a user who is not a merchant nor an admin logs into the system, they are taken to a profile page under a route of "/profile".

### Admins can act on behalf of users
Admin users can access a namespaced route of "/admin/users" to see an index page  of all non-merchant/non-admin users, and from there see each user. This will allow the admin to perform every action on a user's account that the user themselves can perform. Admin users can also "upgrade" a user account to become a merchant account.

```
[ ] done

User Story 19, User Profile Show Page

As a registered user
When I visit my profile page
Then I see all of my profile data on the page except my password
And I see a link to edit my profile data
```

```
[ ] done

User Story 20, User Can Edit their Profile Data

As a registered user
When I visit my profile page
I see a link to edit my profile data
When I click on the link to edit my profile data
I see a form like the registration page
The form is prepopulated with all my current information except my password
When I change any or all of that information
And I submit the form
Then I am returned to my profile page
And I see a flash message telling me that my data is updated
And I see my updated information
```

```
[ ] done

User Story 21, User Can Edit their Password

As a registered user
When I visit my profile page
I see a link to edit my password
When I click on the link to edit my password
I see a form with fields for a new password, and a new password confirmation
When I fill in the same password in both fields
And I submit the form
Then I am returned to my profile page
And I see a flash message telling me that my password is updated
```

```
[ ] done

User Story 22, User Editing Profile Data must have unique Email address

As a registered user
When I attempt to edit my profile data
If I try to change my email address to one that belongs to another user
When I submit the form
Then I am returned to the profile edit page
And I see a flash message telling me that email address is already in use
```

---

## Shopping Cart and Checkout
This is what this app is all about: how a user can put things in a shopping cart and check out, creating an order in the process.

### Visitors and Regular Users only
Merchants and Admin users cannot order items. This will cause a conflict in the project if an admin upgrades a user to a merchant and that user had previous orders of their own. We're not going to worry about this conflict.

```
[ ] done

User Story 23, Visitors must register or log in to check out

As a visitor
When I have items in my cart
And I visit my cart
I see information telling me I must register or log in to finish the checkout process
The word "register" is a link to the registration page
The words "log in" is a link to the login page
```

```
[ ] done

User Story 24, Registered users can check out

As a registered user
When I add items to my cart
And I visit my cart
I see a button or link indicating that I can check out
And I click the button or link to check out
An order is created in the system, which has a status of "pending"
That order is associated with my user
I am taken to my orders page ("/profile/orders")
I see a flash message telling me my order was created
I see my new order listed on my profile orders page
My cart is now empty
```

---

## User Order Show Page
The show page template for an order can be shared between users, merchants and admins to DRY up our presentation logic. They will operate through separate controllers, though.

### User Control
- Users can cancel an order if an admin has not "shipped" that order
- When an order is cancelled, any fulfilled items have their inventory returned to their respective merchants

### Merchant Control
- Merchants only see items in the order that are sold by that merchant
- Items from other merchants are hidden

### Admin Control
- Admins can cancel an order on behalf of a user
- Admins can fulfill items on order on behalf of a merchant

```
[ ] done

User Story 25, User Profile displays Orders link

As a registered user
When I visit my Profile page
And I have orders placed in the system
Then I see a link on my profile page called "My Orders"
When I click this link my URI path is "/profile/orders"
```

```
[ ] done

User Story 26, User Profile displays Orders

As a registered user
When I visit my Profile Orders page, "/profile/orders"
I see every order I've made, which includes the following information:
- the ID of the order, which is a link to the order show page
- the date the order was made
- the date the order was last updated
- the current status of the order
- the total quantity of items in the order
- the grand total of all items for that order
```

```
[ ] done

User Story 27, User views an Order Show Page

As a registered user
When I visit my Profile Orders page
And I click on a link for order's show page
My URL route is now something like "/profile/orders/15"
I see all information about the order, including the following information:
- the ID of the order
- the date the order was made
- the date the order was last updated
- the current status of the order
- each item I ordered, including name, description, thumbnail, quantity, price and subtotal
- the total quantity of items in the whole order
- the grand total of all items for that order
```

```
[ ] done

User Story 28, User cancels an order

As a registered user
When I visit an order's show page
I see a button or link to cancel the order only if the order is still pending
When I click the cancel button for an order, the following happens:
- Each row in the "order items" table is given a status of "unfulfilled"
- The order itself is given a status of "cancelled"
- Any item quantities in the order that were previously fulfilled have their quantities returned to their respective merchant's inventory for that item.
- I am returned to my profile page
- I see a flash message telling me the order is now cancelled
- And I see that this order now has an updated status of "cancelled"
```

```
[ ] done

User Story 29, All Merchants fulfill items on an order

When all items in an order have been "fulfilled" by their merchants
The order status changes from "pending" to "packaged"
```

```
[ ] done

User Story 30, Admin can see all orders

As an admin user
When I log into my dashboard, "/admin/dashboard"
Then I see all orders in the system.
For each order I see the following information:

- user who placed the order, which links to admin view of user profile
- order id
- date the order was created

Orders are sorted by "status" in this order:

- packaged
- pending
- shipped
- cancelled
```

```
[ ] done

User Story 31, Admin can "ship" an order

As an admin user
When I log into my dashboard, "/admin/dashboard"
Then I see any "packaged" orders ready to ship.
Next to each order I see a button to "ship" the order.
When I click that button for an order, the status of that order changes to "shipped"
And the user can no longer "cancel" the order.
```

---

## Merchant Dashboard
This is the landing page when a merchant logs in. Here, they will see their contact information (but cannot change it), some statistics, and a list of pending orders that require the merchant's attention.

### Admins can act on behalf of merchants
Admin users will see more information on the "/merchants" route that all users see. For example, on this page, an admin user can navigate to each merchant's dashboard under a route like "/admin/merchants/7". This will allow the admin to perform every action that the merchant themselves can perform. Admin users can also "downgrade" a merchant account to become a user account.

```
[ ] done

User Story 32, Merchant Dashboard Show Page

As a merchant
When I visit my merchant dashboard ("/merchant")
I see my profile data, but cannot edit it
```

```
[ ] done

User Story 33, Merchant Dashboard displays Orders

As a merchant
When I visit my merchant dashboard ("/merchant")
If any users have pending orders containing items I sell
Then I see a list of these orders.
Each order listed includes the following information:
- the ID of the order, which is a link to the order show page ("/merchant/orders/15")
- the date the order was made
- the total quantity of my items in the order
- the total value of my items for that order
```

```
[ ] done

User Story 34, Merchant's Items index page

As a merchant
When I visit my merchant dashboard
I see a link to view my own items
When I click that link
My URI route should be "/merchant/items"
```

```
[ ] done

User Story 35, Admin can see a merchant's dashboard

As an admin user
When I visit the merchant index page ("/merchants")
And I click on a merchant's name,
Then my URI route should be ("/admin/merchants/6")
Then I see everything that merchant would see
```

---

## Merchant Index Page
All users can see a merchant index page at "/merchants" which will list some basic information about each merchant. When admins visit this page, however, more functionality is found.

```
[ ] done

User Story 36, Admin disables a merchant account

As an admin
When I visit the merchant index page
I see a "disable" button next to any merchants who are not yet disabled
When I click on the "disable" button
I am returned to the admin's merchant index page where I see that the merchant's account is now disabled
And I see a flash message that the merchant's account is now disabled
```

```
[ ] done

User Story 37, Disabled Merchant Item's are inactive

As an admin merchant
When I visit the merchant index page
And I click on the "disable" button for an enabled merchant
Then all of that merchant's items should be deactivated
```

```
[ ] done

User Story 38, Admin enables a merchant account

As an admin merchant
When I visit the merchant index page
I see an "enable" button next to any merchants whose accounts are disabled
When I click on the "enable" button
I am returned to the admin's merchant index page where I see that the merchant's account is now enabled
And I see a flash message that the merchant's account is now enabled
```

```
[ ] done

User Story 39, Enabled Merchant Item's are active

As an admin merchant
When I visit the merchant index page
And I click on the "enable" button for a disabled merchant
Then all of that merchant's items should be activated
```

---

## Merchant Items
Merchants need CRUD functionality for items in the database. These stories will work through the management of items. These routes should be namespaced like "/dashboard/items" and "/dashboard/items/6" and so on. Merchants can disable items so they are no longer for sale but stay in the database so orders are still handled properly. Merchants can fully delete items if nobody has ever ordered it.

### Admin functionality
Admin users share all management functionality, but the routes will be much longer, like "/admin/merchants/8/items" and "/admin/merchants/8/items/6" and so on.

```
[ ] done

User Story 40, Merchant deactivates an item

As a merchant
When I visit my items page
I see a link or button to deactivate the item next to each item that is active
And I click on the "deactivate" button or link for an item
I am returned to my items page
I see a flash message indicating this item is no longer for sale
I see the item is now inactive
```

```
[ ] done

User Story 41, Merchant activates an item

As a merchant
When I visit my items page
I see a link or button to activate the item next to each item that is inactive
And I click on the "activate" button or link for an item
I am returned to my items page
I see a flash message indicating this item is now available for sale
I see the item is now active
```

```
[ ] done

User Story 42, Merchant deletes an item

As a merchant
When I visit my items page
I see a button or link to delete the item next to each item that has never been ordered
When I click on the "delete" button or link for an item
I am returned to my items page
I see a flash message indicating this item is now deleted
I no longer see this item on the page
```

```
[ ] done

User Story 43, Merchant adds an item

As a merchant
When I visit my items page
I see a link to add a new item
When I click on the link to add a new item
I see a form where I can add new information about an item, including:
- the name of the item, which cannot be blank
- a description for the item, which cannot be blank
- a thumbnail image URL string, which CAN be left blank
- a price which must be greater than $0.00
- my current inventory count of this item which is 0 or greater

When I submit valid information and submit the form
I am taken back to my items page
I see a flash message indicating my new item is saved
I see the new item on the page, and it is enabled and available for sale
If I left the image field blank, I see a placeholder image for the thumbnail
```

```
[ ] done

User Story 44, Merchant cannot add an item if details are bad/missing

As a merchant
When I try to add a new item
If any of my data is incorrect or missing (except image)
Then I am returned to the form
I see one or more flash messages indicating each error I caused
All fields are re-populated with my previous data
```

```
[ ] done

User Story 45, Merchant edits an item

As a merchant
When I visit my items page
And I click the edit button or link next to any item
Then I am taken to a form similar to the 'new item' form
The form is pre-populated with all of this item's information
I can change any information, but all of the rules for adding a new item still apply:
- name and description cannot be blank
- price cannot be less than $0.00
- inventory must be 0 or greater

When I submit the form
I am taken back to my items page
I see a flash message indicating my item is updated
I see the item's new information on the page, and it maintains its previous enabled/disabled state
If I left the image field blank, I see a placeholder image for the thumbnail
```

```
[ ] done

User Story 46, Merchant cannot edit an item if details are bad/missing

As a merchant
When I try to edit an existing item
If any of my data is incorrect or missing (except image)
Then I am returned to the form
I see one or more flash messages indicating each error I caused
All fields are re-populated with my previous data
```

---

## Merchant Order Fulfillment
Merchants must "fulfill" each ordered item for users. They will visit an order show page which will allow them to mark each item as fulfilled. Once every merchant marks their items for an order as "fulfilled" then the whole order switches its status to "shipped". Merchants cannot fulfill items in an order if they do not have enough inventory in stock. If a user cancels an order after a merchant has fulfilled an item, the quantity of that item is returned to the merchant.

### Admin functionality
Admins can fulfill items in an order on behalf of a merchant.

```
[ ] done

User Story 47, Merchant sees an order show page

As a merchant
When I visit an order show page from my dashboard
I see the customer's name and address
I only see the items in the order that are being purchased from my merchant
I do not see any items in the order being purchased from other merchants
For each item, I see the following information:
- the name of the item, which is a link to my item's show page
- an image of the item
- my price for the item
- the quantity the user wants to purchase
```

```
[ ] done

User Story 48, Merchant fulfills part of an order

As a merchant
When I visit an order show page from my dashboard
For each item of mine in the order
If the user's desired quantity is equal to or less than my current inventory quantity for that item
And I have not already "fulfilled" that item:
- Then I see a button or link to "fulfill" that item
- When I click on that link or button I am returned to the order show page
- I see the item is now fulfilled
- I also see a flash message indicating that I have fulfilled that item
- the item's inventory quantity is permanently reduced by the user's desired quantity

If I have already fulfilled this item, I see text indicating such.
```

```
[ ] done

User Story 49, Merchant cannot fulfill an order due to lack of inventory

As a merchant
When I visit an order show page from my dashboard
For each item of mine in the order
If the user's desired quantity is greater than my current inventory quantity for that item
Then I do not see a "fulfill" button or link
Instead I see a notice next to the item indicating I cannot fulfill this item
```

---

## User Management by Admins
Admins will need a way to view a list of all regular users and view their profile and order data.

Admins can also change a user's role between being a regular user and a merchant user.

```
[ ] done

User Story 50, Admin Merchant Index Page

As an admin user
When I visit the merchant's index page at "/merchants"
I see all merchants in the system
Next to each merchant's name I see their city and state
The merchant's name is a link to their Merchant Dashboard at routes such as "/admin/merchants/5"
I see a "disable" button next to any merchants who are not yet disabled
I see an "enable" button next to any merchants whose accounts are disabled
```

```
[ ] done

User Story 51, Admin User Index Page

As an admin user
When I click the "Users" link in the nav (only visible to admins)
Then my current URI route is "/admin/users"
Only admin users can reach this path.
I see all users in the system
Each user's name is a link to a show page for that user ("/admin/users/5")
Next to each user's name is the date they registered
Next to each user's name I see what type of user they are
```

```
[ ] done

User Story 52, Admin User Profile Page

As an admin user
When I visit a user's profile page ("/admin/users/5")
I see the same information the user would see themselves
I do not see a link to edit their profile
```

---

## Extensions
If your team finished all other user stories, it is expected that you will begin work on the following additional stories.

The index page indicated in these stories should be namespaced under a route "/admin". This route should only be accessible to admin users of your application. Any functionality mentioned in this epic should be performed by admin users only, and respective routes should all be namespaced under "/admin"

```
[ ] done

User Story 53, EXTENSION: Admin links to User's Order Show from Admin Dashboard

As an admin user
When I visit my dashboard and see all order data
The order ID is a link to an admin-only view of the order
When I click on the link for an order ID,
My URL route is "/admin/users/5/orders/15"
```

```
[ ] done

User Story 54, EXTENSION: Admin views a User's Order Show Page

As an admin user
When I visit a user's profile
And I click on a link for order's show page
My URL route is now something like "/admin/users/5/orders/15"
I see all information about the order, including the following information:
- the ID of the order
- the date the order was made
- the date the order was last updated
- the current status of the order
- each item the user ordered, including name, description, thumbnail, quantity, price and subtotal
- the total quantity of items in the whole order
- the grand total of all items for that order
```

```
[ ] done

User Story 55, EXTENSION: Admin cancels a user's order

As an admin user
When I visit a user's order show page
If the order is still "pending", I see a button or link to cancel the order
When I click the cancel button for an order
The same behaviors happen as if the user canceled the order themselves
```

```
[ ] done

User Story 56, EXTENSION: Admin can edit a user's profile data

As an admin user
When I visit a user's profile page ("/admin/users/5")
And I click the link to edit the user's profile data
The same behaviors exist as if I were that user trying to change their own data
Except I am returned to the show page path of
"/admin/users/5" when I am finished
```

```
[ ] done

User Story 57, EXTENSION: Admin disables a user account

As an admin user
When I visit the user index page
I see a "disable" button next to any users who are not yet disabled
I see an "enable" button next to any users whose accounts are disabled.
If I click on a "disable" button for an enabled user
I am returned to the admin's user index page
And I see a flash message that the user's account is now disabled
And I see that the user's account is now disabled
This user cannot log in
This user's city/state and orders should not be part of any statistics.
```

```
[ ] done

User Story 58, EXTENSION: Admin enables a user account

As an admin user
When I visit the user index page
And I click on a "enable" button for a disabled user
I am returned to the admin's user index page
And I see a flash message that the user's account is now enabled
And I see that the user's account is now enabled
This user can now log in
This user's city/state and orders should be included in all statistics.
```

```
[ ] done

User Story 59, EXTENSION: Admin can manage items on behalf of a merchant

As an admin user
When I visit a merchant's profile page
I can click on the merchant's items link
And have access to all functionality the merchant does, including
- adding new items
- editing existing items
- enabling/disabling/deleting items

All content rules still apply (eg, item name cannot be blank, etc)
```

```
[ ] done

User Story 60, EXTENSION: Admin can fulfill order items on behalf of a merchant

As a merchant
When I visit an order show page from my dashboard
For each item of mine in the order
If the user's desired quantity is greater than my current inventory quantity for that item
Then I do not see a "fulfill" button or link
Instead I see a big red notice next to the item indicating I cannot fulfill this item
```



## Rubric

| | **Feature Completeness** | **Rails** | **ActiveRecord** | **Testing and Debugging** | **Styling, UI/UX** |
| --- | --- | --- | --- | --- | --- |
| **4: Exceptional**  | All User Stories 100% complete including all sad paths and edge cases, and some extension work completed | Students implement strategies not discussed in class to effectively organize code and adhere to MVC. | Highly effective and efficient use of ActiveRecord beyond what we've taught in class. Even `.each` calls will not cause additional database lookups. | Very clear Test Driven Development. Test files are extremely well organized and nested. Students utilize `before :each` blocks. 100% coverage for features and models | Extremely well styled and purposeful layout. Excellent color scheme and font usage. All other rubric categories score 3 or 4. |
| **3: Passing** | Students complete all User Stories. No more than 2 Stories fail to correctly implement sad path and edge case functionality. | Students use the principles of MVC to effectively organize code. Students can defend any of their design decisions. Students limit access to authorized users. | ActiveRecord is used in a clear and effective way to read/write data using no Ruby to process data. | 100% coverage for models. 98% coverage for features. Tests are well written and meaningful. | Purposeful styling pattern and layout using `application.html.erb`. Links or buttons to reach all areas of the site. |
| **2: Passing with Concerns** | Students complete all but 1 - 3 User Stories | Students utilize MVC to organize code, but cannot defend some of their design decisions. Or some functionality is not limited to the appropriately authorized users. | Ruby is used to process data that could use ActiveRecord instead. | Feature test coverage between 90% and 98%, or model test coverage below 100%, or tests are not meaningfully written or have an unclear objective. | Styling is poor or incomplete. Incomplete navigation for some routes, i.e. users must manually type URLs. |
| **1: Failing** | Students fail to complete 4 or more User Stories | Students do not effectively organize code using MVC. Or students do not authorize users. | Ruby is used to process data more often than ActiveRecord | Below 90% coverage for either features or models. | No styling or no buttons or links to navigate the site. |
