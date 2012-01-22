require 'openssl'
require 'base64'
require 'digest/sha2'

class Crypter
  
  def generate_hash(text)
    Digest::SHA2.hexdigest(text)
  end
  
  def encrypt_data(key, text)
    hkey = Digest::SHA2.hexdigest(key)
    return Base64.encode64(Encryptor.encrypt(:key => hkey, :value => text))
  end
    
  def decrypt_string(key, data)
    hkey = Digest::SHA2.hexdigest(key)
    return Encryptor.decrypt(:key => hkey, :value => Base64::decode64(data))
  end
  
end