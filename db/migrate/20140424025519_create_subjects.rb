class CreateSubjects < ActiveRecord::Migration[5.2]
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
    flattened_subject = subjects.join("', NOW(), NOW()), ('")
    execute "INSERT INTO subjects (name, created_at, updated_at) VALUES ('#{flattened_subject}', NOW(), NOW());"
  end
end
