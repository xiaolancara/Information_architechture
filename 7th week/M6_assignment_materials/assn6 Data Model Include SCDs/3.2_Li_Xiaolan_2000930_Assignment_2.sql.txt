use `dav6100_db_2_rpt`;
-- 1. How many Orders by Supplier by Quarter are there?
select fact_orders.supplier_key, dim_date.date_quarter, count(order_key) from
fact_orders,  dim_date
where fact_orders.order_date_key = dim_date.date_string
group by fact_orders.supplier_key, dim_date.date_quarter;

-- Query result:
-- supplier_key,date_quarter,count(order_key)
-- 1082,2,99
-- 3149,2,14
-- 6255,2,86
-- 2157,2,156
-- 9534,2,47
-- 2157,3,856
-- 3537,3,304
-- 9534,3,288
-- 6255,3,784
-- 1629,4,4
-- 4859,4,4
-- 3537,4,4
-- 1082,4,2
-- 5178,4,4
-- 3149,4,78
-- 6255,4,15
-- 2647,4,3


-- 2.1 What is the count of orders by the supplier?
select fact_orders.supplier_key, dim_suppliers.supplier_name, count(order_key) from
fact_orders, dim_suppliers
where fact_orders.supplier_key = dim_suppliers.supplier_key
group by fact_orders.supplier_key;

-- Query Result:
-- supplier_key,supplier_name,count(order_key)
-- 737,"CHESTNUT VALE FEED INC",1
-- 1082,"H SCHRIER & CO INC",519
-- 1629,"MIVILA CORP. MIVILA FOODS",278
-- 2095,"PHILIP M CASCIANO ASSOC. INC PMC ASSOCIATES",22
-- 2157,"PACTO CORPORATION",885
-- 2647,"FINESSE CREATIONS INC",10
-- 2649,"SAM TELL & SON INC",9
-- 2887,"UNIVERSAL COFFEE CORPORATION",280
-- 3149,"WILD PENGUIN CORPORATION",1005
-- 3537,"JAY BEE DISTRIBUTORS INC",275
-- 3865,"BABYLAB INC.",29
-- 4352,"AGRI SALES USA INC",3
-- 4859,"LEGEND & WHITE ANIMAL HEALTH CORP",20
-- 5178,"ELWOOD INTERNATIONAL INC",57
-- 5603,"best home care medical and surgical supplies inc",1
-- 6255,"KEEFE GROUP LLC",1066
-- 9534,"GLOBAL FOOD INDUSTRIES LLC",165
-- 678,"AIR ENGINEERING FILTERS INC",3
-- 2193,"PLAINFIELD FRUIT & PRODUCE CO INCORPORATED",23
-- 1297,"AKED MANAGEMENT LLC MCDONALDS RESTAURANT",1
-- 5822,"Global Packaging Solutions LLC",1
-- 4866,"POINT BLANK ENTERPRISES INC",2
-- 4787,"DANIEL OYEWALE",2
-- 5838,"ROMEO FOODS INC",20
-- 384,"WB MASON CO INC",3
-- 11,"APPCO PAPER & PLASTICS CORP.",1
-- 109,"ATLANTIC BEVERAGE CO INC",2
-- 8435,"700 BROADWAY FOOD CORP",6
-- 4654,"ALTER LEV INC",1
-- 5068,"ONLY THE BEST FOR LESS INC",3
-- 2753,"PECKHAM MATERIALS CORP",1
-- 1199,"GARDEN STATE HIGHWAY PRODUCTS INC",1
-- 1940,"PAPERMART INC",5
-- 9231,"TEAM HENDEL PRODUCTS LLC",6
-- 1406,"KLEARVIEW APPLIANCE CORP",4
-- 5166,"NATIONAL INDUSTRIES FOR THE BLIND",14
-- 9950,"OLIN WINCHESTER LLC",1
-- 1815,"METROPOLITAN FOODS INC DRISCOLL FOODS",3
-- 7431,"946 EIGHTH AVENUE FOOD CORP",3
-- 4404,"DS SERVICES OF AMERICA INC",1
-- 4905,"ROB-ROY ENTERPRISES INC",1
-- 5744,"VISTA OUTDOOR SALES LLC",1
-- 4096,"IMPERIAL BAG & PAPER CO LLC",1
-- 4240,"INDUSTRIAL U.S.A. INC",4
-- 5711,"KRYSTAL TOUCH OF NY INC",1
-- 673,"CENTRAL POLY-BAG CORP",1
-- 4150,"SINGER EQUIPMENT COMPANY INC",4
-- 983,"GENERAL FOUNDRIES INC",7
-- 4721,"ENVIRONMENTAL AGRICULTURAL TRAINING",2
-- 1367,"JAMAC FROZEN FOOD CORP.",27
-- 323,"BORO SAWMILL & TIMBER CO INC",3
-- 5439,"CARDINAL FOODS LLC",16
-- 1052,"FRANK GARGIULO & SON INC",10


-- 2.2 Who are the top 5 suppliers that receive orders based on total orders?
select fact_orders.supplier_key, dim_suppliers.supplier_name, count(order_key) from
fact_orders, dim_suppliers
where fact_orders.supplier_key = dim_suppliers.supplier_key
group by fact_orders.supplier_key
order by count(order_key) desc
limit 5;

-- Query result:
-- supplier_key,supplier_name,count(order_key)
-- 6255,"KEEFE GROUP LLC",1066
-- 3149,"WILD PENGUIN CORPORATION",1005
-- 2157,"PACTO CORPORATION",885
-- 1082,"H SCHRIER & CO INC",519
-- 2887,"UNIVERSAL COFFEE CORPORATION",280


-- 3. How many orders per quarter?
select dim_date.date_quarter, count(order_key) from
fact_orders, dim_date
where fact_orders.order_date_key = dim_date.date_string
group by dim_date.date_quarter;


-- Query result
-- date_quarter,count(order_key)
-- 2,402
-- 3,2232
-- 4,114
