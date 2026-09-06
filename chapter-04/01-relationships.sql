-- =============================================
-- Chapter 4.1
-- =============================================
USE game2;
GO

-- Ex2:
CREATE TABLE orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    
    CONSTRAINT FK_orders_customers
        FOREIGN KEY (customer_id) 
        REFERENCES customers(id)
);
GO

-- Ex3:
CREATE TABLE student_courses (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    
    PRIMARY KEY (student_id, course_id),
    
    CONSTRAINT FK_student_courses_students
        FOREIGN KEY (student_id) 
        REFERENCES students(id),

    CONSTRAINT FK_student_courses_courses
        FOREIGN KEY (course_id) 
        REFERENCES courses(id)
);
GO