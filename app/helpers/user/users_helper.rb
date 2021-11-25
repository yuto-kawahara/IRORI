module User::UsersHelper
  def reserve_status(recruit)
    reserve = recruit.reserves.find_by(user_id: current_user.id)
    @status =  reserve.reserve_status
  end
end
