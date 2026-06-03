/* 1. Расчёт площади круга
Создайте функцию для расчета площади круга, если известен его радиус.
Используйте формулу
Где:
S — площадь шара,
r — радиус шара,
π ≈ 3.14159 */

-- для радиуса 25
SELECT ROUND(PI() * POW(25, 2), 6); -- 1963...

-- в dbeaver у меня работает без begin end и delimiter если есть всего один return ;
CREATE FUNCTION circle_area(r DOUBLE)
RETURNS DOUBLE
DETERMINISTIC
RETURN ROUND(PI() * POW(r, 2), 6);

SELECT circle_area(25); -- 1963....

SELECT circle_area(1); -- 3.141590


/* 2. Расчёт гипотенузы треугольника
Создайте функцию для расчета гипотенузы треугольника, если известны длины его катетов.
Используйте формулу c = SQRT(a * a + b * b)
Где:
c — длина гипотенузы треугольника,
a, b — длины его катетов */

SELECT SQRT(POW(3, 2) + POW(4, 2));

CREATE FUNCTION hypotenuse(a DOUBLE, b DOUBLE)
RETURNS DOUBLE
DETERMINISTIC
RETURN SQRT(POW(a, 2) + POW(b, 2));

SELECT hypotenuse(3, 4);  -- 5
