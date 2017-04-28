class StatementSerializer < ActiveModel::Serializer
  attributes :begin_date, :end_date, :beginning_balance, :ending_balance, :interest_charged
end
