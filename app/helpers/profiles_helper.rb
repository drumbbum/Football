module ProfilesHelper
  def my_profile?(profile)
    current_user.profile.eql?(profile)
  end
  
end
