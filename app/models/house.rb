class House < ActiveRecord::Base
  def self.train_price
    connection = ActiveRecord::Base.connection()
    sql = <<-SQL
      SELECT madlib.linregr_train( 'houses',
                                   'houses_linregr',
                                   'price',
                                   'ARRAY[1, tax, bedroom, bath, size]'
    );
    SQL
    connection.execute sql
  end

  def self.predict_price(house_info)
    connection = ActiveRecord::Base.connection()
    sql = <<-SQL
      select madlib.linregr_predict( ARRAY[1,#{house_info[:tax]},#{house_info[:bedroom]},#{house_info[:bath]},#{house_info[:size]}], houses_linregr.coef) from houses_linregr;
    SQL
    result = connection.execute sql
    result.to_a[0]['linregr_predict']
  end
end