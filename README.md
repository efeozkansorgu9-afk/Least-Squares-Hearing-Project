# Human Hearing Model - Least Squares Fitting 🦻

**Course:** MAT263E - Computational Linear Algebra (Fall 2025)  
**Project Topic 12:** A Least Squares Model for Human Hearing  
**Role:** Hands-on Designer (Role 5)

## 📌 Project Overview
This project applies **Computational Linear Algebra** techniques to model human auditory perception. Using the **Least Squares Method** and **QR Decomposition**, we fit polynomial curves to the standardized **ISO 226:2003** hearing threshold data.

The repository hosts an interactive MATLAB application designed to visualize how mathematical models fit real-world data and demonstrate engineering concepts like **Overfitting** and **Underfitting**.

## 🚀 Features (Interactive Lab)
This MATLAB App offers a "Hands-on" learning experience:
- **Interactive Slider:** Adjust polynomial degrees (1 to 12) in real-time.
- **Audio Experience:** Listen to 20 Hz, 1000 Hz, and 12500 Hz tones to physically experience hearing thresholds.
- **Visual Feedback:** See "Ideal Model" vs. "Overfitting" warnings dynamically.
- **Error Analysis:** Real-time RMSE (Root Mean Square Error) calculation.
- **Modern UI:** Designed with a professional "Scientific Dark" theme.

## 📂 Files
- `Hearing_Final_Fixed.m`: The main MATLAB script containing the application source code.
- `LICENSE`: MIT License file.
- `README.md`: This documentation file.

## 🛠️ How to Run
1. Ensure you have **MATLAB R2020b** or newer installed.
2. Download the `Hearing_Final_Fixed.m` file.
3. Open it in MATLAB and press **Run** (or F5).
4. The interactive window will launch automatically.

## 🧮 Mathematical Background
The core of this project solves the overdetermined system $Ax = b$ using QR Decomposition:
1. Construct the **Vandermonde Matrix** ($A$) based on the chosen polynomial degree.
2. Decompose $A$ into an orthogonal matrix $Q$ and upper triangular matrix $R$ ($A=QR$).
3. Solve for coefficients using back-substitution, providing a numerically stable solution compared to Normal Equations.

## 🔗 References
- **Data Source:** ISO 226:2003 "Acoustics — Normal equal-loudness-level contours".
- **Course Notes:** Week 4 (QR Decomposition) & Week 5 (Iterative Methods).
