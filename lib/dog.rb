class Dog
  
  attr_accessor :name, :breed 
  attr_reader :id 
  
  def initialize(id: nil, name:, breed:)
    @id = id 
    @name = name
    @breed = breed
  end 
  
   def self.create_table
     sql = <<-SQL
     CREATE TABLE IF NOT EXISTS dogs (
     id INTEGER PRIMARY KEY,
     name TEXT,
     breed TEXT);
     SQL
     
     DB[:conn].execute(sql)
   end 
   
   def self.drop_table
     sql = <<-SQL
     DROP TABLE IF EXISTS dogs
     SQL
     
     DB[:conn].execute(sql)
   end 
   
   def new_from_db(row)
     dog = Dog.new(row[0], row[1], row[2])
     dog
   end 
   
   def save
     if self.id
       self.update
     else
     sql = <<-SQL
     INSERT INTO dogs (name, breed)
     VALUES (?,?) 
     SQL
     
     DB[:conn].execute(sql, self.name, self.breed)
     
     @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
     new = Dog.new(name: name, breed: breed)
     new
     end
   end 
   
   def self.find_by_id(id)
     sql = <<-SQL
     SELECT * FROM dogs
     WHERE id = ?
     SQL
     
    DB[:conn].execute(sql, id)[0].map do |row|
      self.ne
   
   end 
   
   def self.create(name:, breed:)
     dog = Dog.new(name: name, breed: breed)
     dog.save
     dog
   end 
   
   def find_or_create_by_name
   end 
   
   def update
     sql = "UPDATE dogs SET name = ?, breed = ? WHERE id = ?"
     DB[:conn].execute(sql, self.name, self.breed, self.id)
   end 
   
   def self.find_by_name
     sql = <<-SQL
     SELECT * FROM dogs
     WHERE name = ?
     SQL
     
     DB[:conn].execute(sql,name)[1]
     new_dog = Dog.new(name: name, breed: breed)
   end 
end 