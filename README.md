# Danny's Diner Case Study 🍣🍜🍛

This repository contains my analysis and SQL solutions for the "Danny's Diner" case study from the [8 Week SQL Challenge](https://8weeksqlchallenge.com/case-study-1/).

---

## 📖 Case Study Overview

**Danny's Diner** is a Japanese food restaurant serving sushi, curry, and ramen. Danny, the owner, is looking to derive insights about his customers' spending habits, favorite dishes, and loyalty program participation.

### **Key Objectives:**
1. Understand customer behavior and spending patterns.
2. Analyze menu item popularity.
3. Explore the impact of the loyalty program.

---

## 📊 Datasets

Three datasets were used for this analysis:
- **sales:** Records customer orders, including `customer_id`, `order_date`, and `product_id`.
- **menu:** Maps `product_id` to menu items and prices.
- **members:** Contains `customer_id` and their `join_date` in the loyalty program.

### Entity Relationship Diagram:

![Danny's Diner](https://github.com/Divyaprasanthi2808/dannys-diner-case-study/blob/main/EER%20diagram.PNG)



---

## 📝 Case Study Questions

The analysis addressed the following questions:

1. **What is the total amount each customer spent at the restaurant?**
2. **How many days has each customer visited the restaurant?**
3. **What was the first item from the menu purchased by each customer?**
4. **What is the most purchased item on the menu and how many times was it purchased by all customers?**
5. **Which item was the most popular for each customer?**
6. **Which item was purchased first by the customer after they became a member?**
7. **Which item was purchased just before the customer became a member?**
8. **What is the total items and amount spent for each member before they became a member?**
9. **How many points would each customer have based on their spending?**
10. **How many points do customers A and B have at the end of January, including 2x points for their first week as members?**

### Bonus Questions:
1. **Recreate a complete transactional dataset including membership status.**
2. **Rank purchases for members only.**

---

## 📂 Repository Structure

- **SQL:** Contains all the SQL queries used for answering the case study questions and bonus tasks.
- **Data:** Includes the datasets used in the analysis (`sales`, `menu`, and `members`).

---

## 🛠️ Tools & Technologies
- **SQL Dialect:** PostgreSQL 13


## Author
This project was carried out by **D.Divyaprasanthi**.

Feel free to connect with me on [LinkedIn](https://www.linkedin.com/in/divyaprasanthi-devavarapu-968bb522b/) for feedback, suggestions, or collaboration opportunities.



