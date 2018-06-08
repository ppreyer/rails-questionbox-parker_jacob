
  json.username @question_username
  json.questionID @question.id
  json.userID @question.user_id
  json.created @question.created_at
  json.updated @question.updated_at
  json.title @question.title
  json.content @question.content
  json.image @question.image.name
   json.answers @question.answers do |answer|
   json.id answer.id
   json.answerUsername @answer_username
   json.answerCreated answer.created_at
   json.answerUpdated answer.updated_at
   json.answerContent answer.content
   json.verify answer.verify_answer
   json.answerUserID answer.user_id
   json.answerimage answer.image.name
   end

