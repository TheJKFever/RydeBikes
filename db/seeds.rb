require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# TODO: put the .com .edu type in here also, or maybe lat/long box params
# somehow a network needs to be defined to a location, possible ip addresses/wifi networks also
Network.create([{
    :name => 'University of Southern California', 
    :domain => 'usc'
  },{
    :name => 'Stanford University', 
    :domain => 'stanford'
  }])

Coordinate.create([{
    :name => 'Bovard', 
    :longitude => -118.285537, 
    :latitude => 34.020914, 
    :network_id => 1
  },{
    :name => 'Waite Phillips', 
    :longitude => -118.283894, 
    :latitude => 34.021955, 
    :network_id => 1
  },{
    :name => 'Social Sciences Building', 
    :longitude => -118.284452, 
    :latitude => 34.021646, 
    :network_id => 1
  },{
    :name => 'Von Kleinsmid Center', 
    :longitude => -118.284468, 
    :latitude => 34.021621, 
    :network_id => 1
  },{
    :name => 'Elvon & Mabel Musick Law Building (Center)', 
    :longitude => -118.284273, 
    :latitude => 34.018675, 
    :network_id => 1
  },{
    :name => 'Bridge', 
    :longitude => -118.28619, 
    :latitude => 34.018805, 
    :network_id => 1
  },{
    :name => 'Center for Electron Microscopy', 
    :longitude => -118.287241, 
    :latitude => 34.019226, 
    :network_id => 1
  },{
    :name => 'College Academic Services Building', 
    :longitude => -118.284087, 
    :latitude => 34.022225, 
    :network_id => 1
  },{
    :name => 'Heritage Hall', 
    :longitude => -118.285406, 
    :latitude => 34.024095, 
    :network_id => 1
  },{
    :name => 'Doheny', 
    :longitude => -118.283725, 
    :latitude => 34.020197, 
    :network_id => 1
  },{
    :name => 'Gerontology Center', 
    :longitude => -118.290403, 
    :latitude => 34.020072, 
    :network_id => 1
  },{
    :name => 'Biegler Hall of Engineering', 
    :longitude => -118.288294, 
    :latitude => 34.020622, 
    :network_id => 1
  },{
    :name => 'Vivian Hall of Engineering', 
    :longitude => -118.287968, 
    :latitude => 34.020014, 
    :network_id => 1
  },{
    :name => 'McClintock Building', 
    :longitude => -118.287284, 
    :latitude => 34.025024, 
    :network_id => 1
  },{
    :name => 'Charles Lee Powell Hall', 
    :longitude => -118.288685, 
    :latitude => 34.018911, 
    :network_id => 1
  },{
    :name => 'Watt Hall', 
    :longitude => -118.287241, 
    :latitude => 34.019226, 
    :network_id => 1
  },{
    :name => 'Annenberg School of Communication', 
    :longitude => -118.286708, 
    :latitude => 34.021953, 
    :network_id => 1
  },{
    :name => 'Taper Hall', 
    :longitude => -118.284381, 
    :latitude => 34.021726, 
    :network_id => 1
  },{
    :name => 'Allan Hancock Foundation', 
    :longitude => -118.285249, 
    :latitude => 34.019763, 
    :network_id => 1
  },{
    :name => 'May Ormerod Harris Hall', 
    :longitude => -118.288379, 
    :latitude => 34.018344, 
    :network_id => 1
  },{
    :name => 'Harold E. And Lillian M. Moulton Organic Chemistry wing', 
    :longitude => -118.286823, 
    :latitude => 34.019951, 
    :network_id => 1
  },{
    :name => 'Laird J Stabler Memorial Hall', 
    :longitude => -118.287123, 
    :latitude => 34.020084, 
    :network_id => 1
  },{
    :name => 'Montgomery Ross Fisher Building', 
    :longitude => -118.282691, 
    :latitude => 34.022129, 
    :network_id => 1
  },{
    :name => 'Kerckhoff Hall', 
    :longitude => -118.279458, 
    :latitude => 34.029362, 
    :network_id => 1
  },{
    :name => 'Leventhal', 
    :longitude => -118.285832, 
    :latitude => 34.019505, 
    :network_id => 1
  },{
    :name => 'Mudd Hall of Philosophy', 
    :longitude => -118.286389, 
    :latitude => 34.018665, 
    :network_id => 1
  },{
    :name => 'Widney Alumni House', 
    :longitude => -118.282825, 
    :latitude => 34.019252, 
    :network_id => 1
  },{
    :name => 'Joint Educational Project House', 
    :longitude => -118.283841, 
    :latitude => 34.022644, 
    :network_id => 1
  },{
    :name => 'Frank Seaver Science Center', 
    :longitude => -118.289403, 
    :latitude => 34.019897, 
    :network_id => 1
  },{
    :name => 'Webb Tower', 
    :longitude => -118.287699, 
    :latitude => 34.024600, 
    :network_id => 1
  },{
    :name => 'Fluor Tower', 
    :longitude => -118.288478, 
    :latitude => 34.024856, 
    :network_id => 1
  },{
    :name => 'Eileen & Kenneth Norris Dental Science Center', 
    :longitude => -118.286331, 
    :latitude => 34.024050, 
    :network_id => 1
  },{
    :name => 'Physical Education Building', 
    :longitude => -118.286966, 
    :latitude => 34.021486, 
    :network_id => 1
  },{
    :name => 'Hedco Petroleum & Chemical Engineering Building', 
    :longitude => -118.289284, 
    :latitude => 34.020086, 
    :network_id => 1
  },{
    :name => 'John Brooks Memorial Pavilion & Dedeaux Field', 
    :longitude => -118.289233, 
    :latitude => 34.022108, 
    :network_id => 1
  },{
    :name => 'James Zumberge Hall of Science', 
    :longitude => -118.286183, 
    :latitude => 34.019200, 
    :network_id => 1
  },{
    :name => 'University Religious Center', 
    :longitude => -118.284011, 
    :latitude => 34.022719, 
    :network_id => 1
  },{
    :name => 'Eileen Norris Cinema Theater', 
    :longitude => -118.284427, 
    :latitude => 34.021749, 
    :network_id => 1
  },{
    :name => 'Henry Salvatori Computer Science Center', 
    :longitude => -118.289284, 
    :latitude => 34.020086, 
    :network_id => 1
  },{
    :name => 'Drama Center', 
    :longitude => -118.289296, 
    :latitude => 34.022135, 
    :network_id => 1
  },{
    :name => 'Virginia Ramo Hall of Music', 
    :longitude => -118.284875, 
    :latitude => 34.023060, 
    :network_id => 1
  },{
    :name => 'Bing Theater', 
    :longitude => -118.286703, 
    :latitude => 34.021970, 
    :network_id => 1
  },{
    :name => 'Albert R Music Faculty Memorial Building', 
    :longitude => -118.284926, 
    :latitude => 34.023082, 
    :network_id => 1
  },{
    :name => 'Birnkrant', 
    :longitude => -118.281427, 
    :latitude => 34.021544, 
    :network_id => 1
  },{
    :name => 'Student Union', 
    :longitude => -118.28575, 
    :latitude => 34.020230, 
    :network_id => 1
  },{
    :name => 'John Hubbard Hall', 
    :longitude => -118.283115, 
    :latitude => 34.019345, 
    :network_id => 1
  },{
    :name => 'David Marks Tennis Stadium', 
    :longitude => -118.289659, 
    :latitude => 34.022289, 
    :network_id => 1
  },{
    :name => 'David Marks Residence Hall', 
    :longitude => -118.282449, 
    :latitude => 34.019678, 
    :network_id => 1
  },{
    :name => 'Elisabeth Von Kleismid Memorial Residence Hall', 
    :longitude => -118.281441, 
    :latitude => 34.020604, 
    :network_id => 1
  },{
    :name => 'May Ormerod Harris Residence Hall', 
    :longitude => -118.281284, 
    :latitude => 34.021480, 
    :network_id => 1
  },{
    :name => 'College Residence Hall', 
    :longitude => -118.281197, 
    :latitude => 34.020500, 
    :network_id => 1
  },{
    :name => 'University Residence Hall', 
    :longitude => -118.280962, 
    :latitude => 34.021337, 
    :network_id => 1
  },{
    :name => 'Hazel & Stanley Hall Financial Services Building', 
    :longitude => -118.287206, 
    :latitude => 34.020156, 
    :network_id => 1
  },{
    :name => 'Seeley  G Mudd ', 
    :longitude => -118.288894, 
    :latitude => 34.021524, 
    :network_id => 1
  },{
    :name => 'Corwin D Denney Research Center', 
    :longitude => -118.290383, 
    :latitude => 34.021554, 
    :network_id => 1
  },{
    :name => 'Town & Gown', 
    :longitude => -118.283618, 
    :latitude => 34.018319, 
    :network_id => 1
  },{
    :name => 'Stonier Hall', 
    :longitude => -118.287066, 
    :latitude => 34.020093, 
    :network_id => 1
  },{
    :name => 'Faculty Center-University Club', 
    :longitude => -118.283826, 
    :latitude => 34.018839, 
    :network_id => 1
  },{
    :name => 'Parkside Apartments', 
    :longitude => -118.290372, 
    :latitude => 34.018907, 
    :network_id => 1
  },{
    :name => 'Robert Glen Rapp Engineering Research Building', 
    :longitude => -118.287263, 
    :latitude => 34.020146, 
    :network_id => 1
  },{
    :name => 'Trojan Residence Hall', 
    :longitude => -118.282145, 
    :latitude => 34.019486, 
    :network_id => 1
  },{
    :name => 'Jerry & Nancy Neely Petroleum & Chemical Engineering Building', 
    :longitude => -118.289284, 
    :latitude => 34.020086, 
    :network_id => 1
  },{
    :name => 'McDonalds Olympic Swim Stadium', 
    :longitude => -118.287947, 
    :latitude => 34.023765, 
    :network_id => 1
  },{
    :name => 'Jefferson Building', 
    :longitude => -118.287102, 
    :latitude => 34.025027, 
    :network_id => 1
  },{
    :name => 'John Stauffer Hall of Science', 
    :longitude => -118.287241, 
    :latitude => 34.019226, 
    :network_id => 1
  },{
    :name => 'John Stauffer Science Lecture Hall', 
    :longitude => -118.287241, 
    :latitude => 34.019226, 
    :network_id => 1
  },{
    :name => 'Parkside Residential Building', 
    :longitude => -118.289536, 
    :latitude => 34.018831, 
    :network_id => 1
  },{
    :name => 'Hoffman Hall', 
    :longitude => -118.285352, 
    :latitude => 34.018565, 
    :network_id => 1
  },{
    :name => 'Willis Booth Ferris Rehearsal Hall', 
    :longitude => -118.284823, 
    :latitude => 34.023037, 
    :network_id => 1
  },{
    :name => 'Olin Hall of Engineering', 
    :longitude => -118.289591, 
    :latitude => 34.020702, 
    :network_id => 1
  },{
    :name => 'Marks Tower', 
    :longitude => -118.282077, 
    :latitude => 34.019704, 
    :network_id => 1
  },{
    :name => 'University Club at King Stoops Hall', 
    :longitude => -118.283132, 
    :latitude => 34.022609, 
    :network_id => 1
  },{
    :name => 'Grace Ford Salvatori Hall', 
    :longitude => -118.287192, 
    :latitude => 34.021192, 
    :network_id => 1
  },{
    :name => 'Pardee Tower', 
    :longitude => -118.282589, 
    :latitude => 34.020020, 
    :network_id => 1
  },{
    :name => 'The Music Complex', 
    :longitude => -118.285895, 
    :latitude => 34.023222, 
    :network_id => 1
  },{
    :name => 'Cinema Television Center Complex', 
    :longitude => -118.285895, 
    :latitude => 34.023222, 
    :network_id => 1
  },{
    :name => 'Hedco Neurosciences Building', 
    :longitude => -118.288051, 
    :latitude => 34.020630, 
    :network_id => 1
  },{
    :name => 'Kaprielian Hall', 
    :longitude => -118.291453, 
    :latitude => 34.022555, 
    :network_id => 1
  },{
    :name => 'University Bookstore', 
    :longitude => -118.285657, 
    :latitude => 34.020502, 
    :network_id => 1
  },{
    :name => 'Hughes Aircraft Electrical Engineering Center', 
    :longitude => -118.290117, 
    :latitude => 34.019728, 
    :network_id => 1
  },{
    :name => 'Leavey Library', 
    :longitude => -118.281451, 
    :latitude => 34.020643, 
    :network_id => 1
  },{
    :name => 'Ralph & Goldy Lewis Hall', 
    :longitude => -118.282883, 
    :latitude => 34.019242, 
    :network_id => 1
  },{
    :name => 'Popovich Hall', 
    :longitude => -118.282324, 
    :latitude => 34.018379, 
    :network_id => 1
  },{
    :name => 'Loker Track Stadium', 
    :longitude => -118.288526, 
    :latitude => 34.022801, 
    :network_id => 1
  },{
    :name => 'Internationally Themed Residential College', 
    :longitude => -118.290968, 
    :latitude => 34.019375, 
    :network_id => 1
  },{
    :name => 'Social Work Center', 
    :longitude => -118.281313, 
    :latitude => 34.021528, 
    :network_id => 1
  },{
    :name => 'Ronald Tutor Hall of Engineering', 
    :longitude => -118.289959, 
    :latitude => 34.020137, 
    :network_id => 1
  },{
    :name => 'Dornsife Neuroscience Imaging Center', 
    :longitude => -118.288894, 
    :latitude => 34.021524, 
    :network_id => 1
  },{
    :name => 'School of Cinematic Arts', 
    :longitude => -118.287198, 
    :latitude => 34.02333, 
    :network_id => 1
  }])

# TODO: create multiple addresses
# create an address for users
Address.create({
    street: Faker::Address.street_address,
    apt: '',
    city: 'Los Angeles',
    zipcode: '90007',
    state: 'CA'
  })
