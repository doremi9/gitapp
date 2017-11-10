class OmniauthParserService

  def parse(params)
    {
      login: params.info.name, 
      uid: params.uid,
      image: params.info.image
    }
  end

end