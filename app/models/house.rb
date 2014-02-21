class House < ActiveRecord::Base
  establish_connection "hawq_#{Rails.env}"

  def self.train_price
    connection = House.connection()

    output_table = 'houses_linregr'

    cleanup_sql = <<-SQL
      DROP TABLE IF EXISTS #{output_table};
      DROP TABLE IF EXISTS #{output_table}_summary;
    SQL

    train_sql = <<-SQL
      SELECT madlib.linregr_train( 'houses',
                                   '#{output_table}',
                                   'price',
                                   'ARRAY[1, tax, bedroom, bath, size]'
    );
    SQL
    connection.execute cleanup_sql
    connection.execute train_sql
  end

  def self.predict_price(house_info)
    connection = House.connection()
    sql = <<-SQL
      select madlib.linregr_predict( ARRAY[1,#{house_info[:tax]},#{house_info[:bedroom]},#{house_info[:bath]},#{house_info[:size]}], houses_linregr.coef) from houses_linregr;
    SQL
    result = connection.execute sql
    result.to_a[0]['linregr_predict']
  end
end