class CreateTaskRequestAndContributing < ActiveRecord::Migration
  def change
    create_table :requests, id: false do |t|
      t.belongs_to :requester, index: true
      t.belongs_to :requested_task, index: true
    end

    create_table :task_members, id: false do |t|
      t.belongs_to :own_task, index: true
      t.belongs_to :contributor, index: true
    end
  end
end
