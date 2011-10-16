require 'openssl'
require 'base64'
require 'digest/sha2'

class Crypter
  
  def generate_hash(text)
    Digest::SHA2.hexdigest(text)
  end
  
  def encrypt_data(key, text)
    c = OpenSSL::Cipher.new('aes-256-cbc')
    c.encrypt
    c.key = k = Digest::SHA2.hexdigest(key)
    c.iv = k
    e = c.update(text)
    e << c.final
    r = Base64::encode64(e)
    return r
  end
    
  def decrypt_string(key, data)
    c = OpenSSL::Cipher.new('aes-256-cbc')
    c.decrypt
    c.key = Digest::SHA2.hexdigest(key)
    d = c.update(Base64.decode64(data))
    d << c.final
    d
  end
  
end