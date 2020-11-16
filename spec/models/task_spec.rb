# encoding: utf-8
require 'rails_helper'

RSpec.describe Task, type: :model do
  user = FactoryBot.create(:user)
  it "is valid with a name, memo" do
    task = user.tasks.build(
      name: "test",
      memo: "this task is test",
      user_id: user.id
    )
    expect(task).to be_valid
  end

  it "is invalid without a name" do
    task = user.tasks.build(name: nil, user_id: user.id)
    task.valid?
    expect(task.errors[:name]).to include("を入力してください")
  end  

  it "is returns a taks's name as a string" do
    task = user.tasks.build(name: "test", user_id: user.id)
    expect(task.name).to be_a(String) 
  end

end
