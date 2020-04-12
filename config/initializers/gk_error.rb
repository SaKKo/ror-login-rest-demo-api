Rails.configuration.to_prepare do
  class GKError < StandardError
  end

  class GKAuthenticationError < StandardError
  end

  class GKUserNotFoundError < StandardError
  end

  class GKNotAuthorizedError < StandardError
  end
end
