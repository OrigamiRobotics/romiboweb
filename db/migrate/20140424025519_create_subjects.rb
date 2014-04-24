class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.text   :description

      t.timestamps
    end

    add_index :subjects, :name
    subjects = [
        "Being Flexible",
        "Bullying",
        "Circle Time",
        "Cooperation",
        "Critical Thinking",
        "Expressive Identification",
        "Eye Contact",
        "Feeding",
        "Greetings",
        "Intraverbals",
        "Joining Play",
        "Listener responding",
        "LRFFC",
        "Manding",
        "Motor imitation",
        "Motor Planning",
        "Nonverbal communication",
        "Peer Imitation",
        "Personal Space",
        "Pretend Play",
        "Receptive Identification",
        "Schedules",
        "Self Help",
        "Sensory Involvement",
        "Sharing",
        "Social Stories",
        "Symbolic Play",
        "Tacting",
        "Theory of Mind",
        "Toileting",
        "Transitions",
        "Turn-taking",
        "Visual Discrimination",
        "Visual/perceptual skills",
        "Vocal Discrimination",
        "Vocal imitation",
        "WH Questions",
        "Yes/No",
        "Zones of Regulation"
    ]
    flattened_subject = subjects.join("'), ('")
    execute "INSERT INTO subjects (name) VALUES ('#{flattened_subject}');"
  end
end
