require 'json'

def read_nodes
  file_path = 'db/nodes.json'
  file_content = File.read(file_path)
  JSON.parse(file_content)['nodes']
end

nodes_data = read_nodes

def create_node(node_data)
  param = {
    id: node_data['id'],
    name: node_data['name'],
    summary: node_data['summary'],
    sort: node_data['sort'],
    updated_at: node_data['updated_at'],
    created_at: node_data['updated_at']
  }

  Node.create(param)
end

nodes_data.each do |node_data|
  create_node(node_data)
end

def read_users
  file_path = 'db/users.json'
  file_content = File.read(file_path)
  JSON.parse(file_content)['users']
end

users_data = read_users

def create_user(user_data)
  param = {
    id: user_data['id'],
    login: user_data['login'],
    name: user_data['name'],
    email: "#{user_data['id']}@example.com",
    password: '123456abc',
    # avatar_url: user_data['avatar_url']
  }

  User.create!(param)
end

users_data.each do |user_data|
  create_user(user_data)
end

puts "Current User count #{User.count}"

def read_topics
  file_path = 'db/topics.json'
  file_content = File.read(file_path)
  JSON.parse(file_content)['topics']
end

topics_data = read_topics

# topic_data = {"id"=>43706,
#               "title"=>"[上海 / 外企] [远程] Xometry（择幂科技）招聘一名 Full Stack 工程师",
#               "created_at"=>"2024-05-24T02:54:59.936Z",
#               "updated_at"=>"2024-05-25T23:59:28.405Z",
#               "replied_at"=>"2024-05-25T23:59:28.313Z",
#               "replies_count"=>6,
#               "node_id"=>25,
#               "node_name"=>"招聘",
#               "last_reply_user_id"=>2948,
#               "last_reply_user_login"=>"sg552sg552",
#               "grade"=>"normal",
#               "likes_count"=>3,
#               "suggested_at"=>nil,
#               "closed_at"=>nil,
#               "deleted"=>false,
#               "user"=>{"id"=>15208, "login"=>"naivecai", "name"=>"麦迪", "avatar_url"=>"https://l.ruby-china.com/user/avatar/15208.jpg!large", "abilities"=>{"update"=>false, "destroy"=>false}},
#               "excellent"=>0,
#               "hits"=>441,
#               "abilities"=>{"update"=>false, "destroy"=>false, "ban"=>false, "normal"=>false, "excellent"=>false, "unexcellent"=>false, "close"=>false, "open"=>false}}

@user_ids = User.pluck(:id)
def create_topic(topic_data)
  node_id = topic_data['node_id']
  node = Node.find(node_id)
  raise 'node not found' if node.nil?

  param = {
    id: topic_data['id'],
    title: topic_data['title'],
    created_at: topic_data['created_at'],
    updated_at: topic_data['updated_at'],
    replied_at: topic_data['replied_at'],
    replies_count: topic_data['replies_count'],
    node_id: topic_data['node_id'],
    # node_name: topic_data['node_name'],
    last_reply_id: topic_data['last_reply_user_id'],
    last_reply_user_id: topic_data['last_reply_user_id'],
    last_reply_user_login: topic_data['last_reply_user_login'],
    grade: topic_data['grade'],
    likes_count: topic_data['likes_count'],
    suggested_at: topic_data['suggested_at'],
    closed_at: topic_data['closed_at'],
    # deleted: topic_data['deleted'],
    user_id: @user_ids.sample,
    body: 'placeholder'
    # excellent: topic_data['excellent'],
    # hits: topic['hits'],
  }

  Topic.create(param)
end

topics_data.each do |topic_data|
  create_topic(topic_data)
end

puts "Current Topic count #{Topic.count}"