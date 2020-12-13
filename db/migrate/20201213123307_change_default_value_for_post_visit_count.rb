class ChangeDefaultValueForPostVisitCount < ActiveRecord::Migration[6.0]
  def change
    change_column_default :posts, :visit_count, from: nil, to: 0
  end
end
