class Compute

  def initialize(projects)
    @projects = projects
  end

  def computer
    computed_data = []
    connection = ActiveRecord::Base.connection.raw_connection
    connection.prepare('totaling', "SELECT SUM(pledges.amount_cents) AS somme, pledges.project FROM pledges WHERE pledges.project=$1 AND pledges.status=$2 AND pledges.typeaction=$3 GROUP BY pledges.project")
    @projects.each do |proj|
      mhash = {}
      mhash[:project] = proj
      pledged = 0
      st_pledged = connection.exec_prepared('totaling', [ proj.id, "paid", "pledge" ])
      st_pledged.each do |tup|
        pledged = tup["somme"]
      end
      mhash[:pledged] = pledged

      guaranteed = 0
      st_guaranteed = connection.exec_prepared('totaling', [ proj.id, "paid", "guarantee" ])
      st_guaranteed.each do |tup|
        guaranteed = tup["somme"]
      end
      mhash[:guaranteed] = guaranteed
      # res_pledged = ActiveRecord::Base.connection.execute("SELECT SUM(pledges.amount_cents), pledges.project FROM pledges WHERE pledges.project=? AND pledges.status=? AND pledges.typeaction=? GROUP BY pledges.project", proj.id, "paid", "pledge")
      # res_guaranteed = ActiveRecord::Base.connection.execute("SELECT SUM(pledges.amount_cents), pledges.project FROM pledges WHERE pledges.project=? AND pledges.status=? AND pledges.typeaction=? GROUP BY pledges.project", proj.id, "paid", "guarantee")
      computed_data << mhash
    end
    connection.exec("DEALLOCATE totaling")
    return computed_data
  end

end
