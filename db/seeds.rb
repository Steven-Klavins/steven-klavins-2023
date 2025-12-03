if Rails.env.development?

  # Create Admin User
  User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

  puts "Created sample admin user..."
  puts "username: 'admin@example.com' password: 'password'"

  # Create Categories
  categories_data = [
    { name: "Education", image: "education.webp" },
    { name: "Study", image: "study.webp" },
    { name: "Electronics", image: "electronics.webp" },
    { name: "Ruby", image: "ruby.webp" }
  ]

  # Attach cover images to Categories
  categories = categories_data.map do |data|
    category = Category.create!(name: data[:name])

    image_path = Rails.root.join("db/seed_images/categories/#{data[:image]}")
    category.cover_image.attach(
      io: File.open(image_path),
      filename: data[:image],
      content_type: "image/webp" # or detect automatically
    )

    category
  end

  puts "Created #{categories_data.count} categories..."

  # Create 20 Blogs with 1-4 random Categories and a random cover image
  blog_images = Dir[Rails.root.join("db/seed_images/blogs/*")]

  20.times do
    blog = Blog.create!(
      title: Faker::Book.title,
      body: Faker::Lorem.paragraphs(number: 3).join("\n\n"),
      draft: false
    )

    # Assign 1–4 random categories
    blog.categories << categories.sample(rand(1..4))

    # Assign random cover image
    image_path = blog_images.sample
    blog.cover_image.attach(
      io: File.open(image_path),
      filename: File.basename(image_path),
      content_type: "image/webp"
    )
  end

  puts "Created 20 blogs..."

  # Experience data
  experience_data = [
    {
      company: "Amphora",
      position: "Software Engineer",
      description: "For more than two years I worked for Amphora Research Systems as a Full-Stack Software Engineer.
                    I was responsible for developing several commercially launched applications as well as maintaining
                    a variety of others. My responsibilities encompassed a wide range of tasks, including implementing
                    feature requests, conducting upgrades, designing front-end UIs, performing testing, and managing
                    deployment processes.",
      start_date: Date.new(2021, 02, 1),
      end_date: Date.new(2023, 05, 1),
      logo: "amphora-logo.png"
    },

    {
      company: "Elysium",
      position: "Software Engineer",
      description: "During my time at Elysium I played a crucial role in the development, maintenance, and architecture
                    of multiple flagship applications. I collaborated with project managers, DevOps teams, UI/UX
                    designers, penetration testers, and QA analysts to drive successful outcomes.",
      start_date: Date.new(2023, 11, 1),
      end_date: Date.new(2025, 03, 1),
      logo: "elysium-logo.png"
    }
  ]

  # Create Experiences with attached images
  experience_data.each do |data|
    experience = Experience.new(
      company: data[:company],
      position: data[:position],
      description: data[:description],
      start_date: data[:start_date],
      end_date: data[:end_date]
    )

    logo_path = Rails.root.join("db/seed_images/experiences/#{data[:logo]}")

    experience.company_logo.attach(
      io: File.open(logo_path),
      filename: data[:logo],
      content_type: "image/png"
    )

    experience.save!
  end

  puts "Created #{experience_data.count} experiences..."
end
