Rails.configuration.to_prepare do
  class ApiJwt
    def self.encrypt_jwt(payload, secret, exp = nil, nbf = nil)
      now = Time.now.to_i
      payload[:exp] = exp || now + 1.hour
      token = JWT.encode(payload, secret, "HS256")
      token
    end

    def self.encrypt_life_time_jwt(payload, secret, nbf = nil)
      token = JWT.encode(payload, secret, "HS256")
      token
    end

    def self.decrypt_jwt(token, secret, leeway = 30)
      decoded = {}
      options = {
        leeway: leeway,
        algorithm: "HS256",
      }
      decoded = JWT.decode(token, secret, true, options)
      decoded.first.with_indifferent_access
    end

    def self.decrypt_without_verify(token)
      JWT.decode(token, "secret", false).first.with_indifferent_access
    end
  end
end
