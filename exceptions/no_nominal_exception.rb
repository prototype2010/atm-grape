class NoNominalException < StandardError
  def message
    'Cannot give out the amount by existing nominal'
  end
end
