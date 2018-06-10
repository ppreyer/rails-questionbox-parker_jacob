  json.questions @questions do |question|
   json.id question.id
   json.userID question.user_id
   json.username @question_username
   json.created_at question.created_at
   json.updated_at question.updated_at
   json.title question.title
   json.content question.content
   json.image question.image.name
   end
