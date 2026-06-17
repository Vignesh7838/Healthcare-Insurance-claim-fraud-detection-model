Health Insurance Fraud detection Model
Objective :   The primary goal of this model is to identify and flag fraudulent healthcare claims within a dataset of 10,000 records. Specifically, it aims to:

•	Minimize Financial Loss: Detect "over-billing" or "phantom billing" where the Claim_Amount is significantly higher than the Approved_Amount.
•	Identify High-Risk Providers: Analyze Provider_ID and Number_of_Claims_Per_Provider_Monthly to find patterns of suspicious activity.
•	Automate Auditing: Shift from manual claim review to an automated system that flags claims where Is_Fraud is likely to be 1.

. Problems Faced During Model Building
Building a fraud detection model often involves several "Phase 1" hurdles:
•	Class Imbalance: In healthcare, fraudulent claims usually make up less than 1-5% of total data. If the model sees 99% "Normal" claims, it might simply learn to predict "Normal" every time to achieve high accuracy while failing to catch actual fraud.
•	Feature Complexity: Categorical data like Diagnosis_Code (e.g., I25.10) and Procedure_Code (e.g., 36415) require extensive encoding (One-Hot or Label Encoding) because they are high-cardinality features.
•	Temporal Dynamics: Fraud patterns change over time. Using Claim_Submission_Date requires converting strings into usable features like Month, DayOfWeek, or Season.
•	Data Leakage: Ensuring that info known only after a fraud investigation is completed isn't used to train the model, which would create an unrealistic "perfect" accuracy.


Category	Tools / Techniques
Language	Python 3 (ipykernel)
Libraries	pandas (Data manipulation), numpy (Numerical Ops), matplotlib/seaborn (Visualization)
Feature Engineering	Handling Days_Between_Service_and_Claim and Chronic_Condition_Flag
Environment	JupyterLab
