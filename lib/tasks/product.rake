namespace :product do
  desc "TODO"
  task update_slug: :environment do
    Product.where(slug: [nil, '']).each do |product|
      s = "#{product.code} #{product.project.name}"
      slug = pre_slug = s.mb_chars.normalize(:kd).gsub(/\p{Mn}/, '').downcase.to_s.parameterize
      i = 1
      while Product.exists?(slug: slug)
        slug = "#{pre_slug}-#{i}"
        i += 1
      end
      product.update_attributes(slug: slug)
    end
  end
end
