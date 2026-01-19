-- Изменение регистра
-- Создайте функцию для перевода текста в верхний регистр. 
-- Функция принимает строку и возвращает её в верхнем регистре, 
-- добавив восклицательный знак в конце.

DELIMITER //
CREATE FUNCTION make_uppercase(user_text VARCHAR(100))
RETURNS VARCHAR(101)
DETERMINISTIC
BEGIN
	RETURN CONCAT(UPPER(user_text), "!");
END //

DELIMITER ;

SELECT make_uppercase("new_text");