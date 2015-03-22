# Creater Users
teacher1 = User.find_or_create_by(email: 'teacher1@fakemail.com') do |user|
  user.first_name = 'Teacher'
  user.last_name = 'One'
  user.password = '1234'
  user.password_confirmation = '1234'
end

teacher2 = User.find_or_create_by(email: 'teacher2@fakemail.com') do |user|
  user.first_name = 'Teacher'
  user.last_name = 'Two'
  user.password = '1234'
  user.password_confirmation = '1234'
end

student1 = User.find_or_create_by(email: 'ahmed@helpcue.com') do |user|
  user.first_name = 'Student'
  user.last_name = 'One'
  user.password = '1234'
  user.password_confirmation = '1234'
end

student2 = User.find_or_create_by(email: 'paula@helpcue.com') do |user|
  user.first_name = 'Student'
  user.last_name = 'Two'
  user.password = '1234'
  user.password_confirmation = '1234'
end

student3 = User.find_or_create_by(email: 'nachiket@helpcue.com') do |user|
  user.first_name = 'Student'
  user.last_name = 'Three'
  user.password = '1234'
  user.password_confirmation = '1234'
end

student4 = User.find_or_create_by(email: 'alexander@helpcue.com') do |user|
  user.first_name = 'Student'
  user.last_name = 'Four'
  user.password = '1234'
  user.password_confirmation = '1234'
end

# Create Classroom
sample_classroom = Classroom.find_or_initialize_by(user_token: 'rDFioTXR') do |classroom|
  classroom.name = 'Sample Classroom'
  classroom.description = 'This classroom is used for testing and demonstration purposes only.'
end

sample_classroom.owner = teacher1
sample_classroom.save
sample_classroom.enrollments.create(user: teacher1, role: 'Admin')

# Teacher Two joins
sample_classroom.enrollments.create(user: teacher2, role: 'Admin')

# Students join
sample_classroom.enrollments.create(user: student1, role: 'Member')
sample_classroom.enrollments.create(user: student2, role: 'Member')
sample_classroom.enrollments.create(user: student3, role: 'Member')
sample_classroom.enrollments.create(user: student4, role: 'Member')
