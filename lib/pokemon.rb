class Pokemon

    attr_reader :id, :db
    attr_accessor :name, :type

    @@all = []

    def initialize(name:, type:, db:, id:)
        @id = id
        @name = name
        @type = type
        @db = db
        @@all << self
    end

    def self.save(name, type, db)
        #creates a new pokemon, assigns an id, saves to database
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
                VALUES (?, ?)
            SQL
        db.execute(sql, name, type)
        db.execute("SELECT last_insert_rowid() students")[0][0]
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * FROM pokemon WHERE id = ?
            LIMIT 1
            SQL
        row = db.execute(sql, id).first
        pokemon = Pokemon.new(id: row[0], name: row[1], type: row[2], db: db)
    end

    def self.all
        @@all
    end
end
