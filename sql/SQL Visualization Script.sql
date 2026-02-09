#Analyzing user behaviour based on recency levels




SELECT CASE 
WHEN DATE_DIFF(DATE '2025-12-31',LastPurchaseDate,DAY)<219 THEN '140-218 days'
WHEN DATE_DIFF(DATE '2025-12-31',LastPurchaseDate,DAY)<288 THEN '219-288 days'
ELSE '288+ days' END AS Recency,
COUNT(*) as user_count,
AVG(FirstPurchaseDaysAfterInstall) as avg_first_purchase,
AVG(InAppPurchaseAmount) as avg_spend,
AVG(SessionCount) as avg_sessions,
AVG(AverageSessionLength) as avg_duration,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),2) as user_share_pct,
ROUND(SUM(InAppPurchaseAmount)*100/SUM(SUM(InAppPurchaseAmount)) OVER (),2) as revenue_share_pct,
ROUND(SUM(InAppPurchaseAmount)/COUNT(UserID),2) as ARPU_by_recency
FROM mobile_game.purchased
GROUP BY Recency