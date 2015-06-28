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

Coordinate.create([{{
    :name => 'Bovard', 
    :latitude => -118.285537, 
    :longitude => 34.020914, 
    :network_id => 1
  },{
    :name => 'Waite Phillips', 
    :latitude => -118.283894, 
    :longitude => 34.021955, 
    :network_id => 1
  },{
    :name => 'Social Sciences Building', 
    :latitude => -118.284452, 
    :longitude => 34.021646, 
    :network_id => 1
  },{
    :name => 'Von Kleinsmid Center', 
    :latitude => -118.284468, 
    :longitude => 34.021621, 
    :network_id => 1
  },{
    :name => 'Elvon & Mabel Musick Law Building (Center)', 
    :latitude => -118.284273, 
    :longitude => 34.018675, 
    :network_id => 1
  },{
    :name => 'Bridge', 
    :latitude => -118.28619, 
    :longitude => 34.018805, 
    :network_id => 1
  },{
    :name => 'Center for Electron Microscopy', 
    :latitude => -118.287241, 
    :longitude => 34.019226, 
    :network_id => 1
  },{
    :name => 'College Academic Services Building', 
    :latitude => -118.284087, 
    :longitude => 34.022225, 
    :network_id => 1
  },{
    :name => 'Heritage Hall', 
    :latitude => -118.285406, 
    :longitude => 34.024095, 
    :network_id => 1
  },{
    :name => 'Doheny', 
    :latitude => -118.283725, 
    :longitude => 34.020197, 
    :network_id => 1
  },{
    :name => 'Gerontology Center', 
    :latitude => -118.290403, 
    :longitude => 34.020072, 
    :network_id => 1
  },{
    :name => 'Biegler Hall of Engineering', 
    :latitude => -118.288294, 
    :longitude => 34.020622, 
    :network_id => 1
  },{
    :name => 'Vivian Hall of Engineering', 
    :latitude => -118.287968, 
    :longitude => 34.020014, 
    :network_id => 1
  },{
    :name => 'McClintock Building', 
    :latitude => -118.287284, 
    :longitude => 34.025024, 
    :network_id => 1
  },{
    :name => 'Charles Lee Powell Hall', 
    :latitude => -118.288685, 
    :longitude => 34.018911, 
    :network_id => 1
  },{
    :name => 'Watt Hall', 
    :latitude => -118.287241, 
    :longitude => 34.019226, 
    :network_id => 1
  },{
    :name => 'Annenberg School of Communication', 
    :latitude => -118.286708, 
    :longitude => 34.021953, 
    :network_id => 1
  },{
    :name => 'Taper Hall', 
    :latitude => -118.284381, 
    :longitude => 34.021726, 
    :network_id => 1
  },{
    :name => 'Allan Hancock Foundation', 
    :latitude => -118.285249, 
    :longitude => 34.019763, 
    :network_id => 1
  },{
    :name => 'May Ormerod Harris Hall', 
    :latitude => -118.288379, 
    :longitude => 34.018344, 
    :network_id => 1
  },{
    :name => 'Harold E. And Lillian M. Moulton Organic Chemistry wing', 
    :latitude => -118.286823, 
    :longitude => 34.019951, 
    :network_id => 1
  },{
    :name => 'Laird J Stabler Memorial Hall', 
    :latitude => -118.287123, 
    :longitude => 34.020084, 
    :network_id => 1
  },{
    :name => 'Montgomery Ross Fisher Building', 
    :latitude => -118.282691, 
    :longitude => 34.022129, 
    :network_id => 1
  },{
    :name => 'Kerckhoff Hall', 
    :latitude => -118.279458, 
    :longitude => 34.029362, 
    :network_id => 1
  },{
    :name => 'Leventhal', 
    :latitude => -118.285832, 
    :longitude => 34.019505, 
    :network_id => 1
  },{
    :name => 'Mudd Hall of Philosophy', 
    :latitude => -118.286389, 
    :longitude => 34.018665, 
    :network_id => 1
  },{
    :name => 'Widney Alumni House', 
    :latitude => -118.282825, 
    :longitude => 34.019252, 
    :network_id => 1
  },{
    :name => 'Joint Educational Project House', 
    :latitude => -118.283841, 
    :longitude => 34.022644, 
    :network_id => 1
  },{
    :name => 'Frank Seaver Science Center', 
    :latitude => -118.289403, 
    :longitude => 34.019897, 
    :network_id => 1
  },{
    :name => 'Webb Tower', 
    :latitude => -118.287699, 
    :longitude => 34.024600, 
    :network_id => 1
  },{
    :name => 'Fluor Tower', 
    :latitude => -118.288478, 
    :longitude => 34.024856, 
    :network_id => 1
  },{
    :name => 'Eileen & Kenneth Norris Dental Science Center', 
    :latitude => -118.286331, 
    :longitude => 34.024050, 
    :network_id => 1
  },{
    :name => 'Physical Education Building', 
    :latitude => -118.286966, 
    :longitude => 34.021486, 
    :network_id => 1
  },{
    :name => 'Hedco Petroleum & Chemical Engineering Building', 
    :latitude => -118.289284, 
    :longitude => 34.020086, 
    :network_id => 1
  },{
    :name => 'John Brooks Memorial Pavilion & Dedeaux Field', 
    :latitude => -118.289233, 
    :longitude => 34.022108, 
    :network_id => 1
  },{
    :name => 'James Zumberge Hall of Science', 
    :latitude => -118.286183, 
    :longitude => 34.019200, 
    :network_id => 1
  },{
    :name => 'University Religious Center', 
    :latitude => -118.284011, 
    :longitude => 34.022719, 
    :network_id => 1
  },{
    :name => 'Eileen Norris Cinema Theater', 
    :latitude => -118.284427, 
    :longitude => 34.021749, 
    :network_id => 1
  },{
    :name => 'Henry Salvatori Computer Science Center', 
    :latitude => -118.289284, 
    :longitude => 34.020086, 
    :network_id => 1
  },{
    :name => 'Drama Center', 
    :latitude => -118.289296, 
    :longitude => 34.022135, 
    :network_id => 1
  },{
    :name => 'Virginia Ramo Hall of Music', 
    :latitude => -118.284875, 
    :longitude => 34.023060, 
    :network_id => 1
  },{
    :name => 'Bing Theater', 
    :latitude => -118.286703, 
    :longitude => 34.021970, 
    :network_id => 1
  },{
    :name => 'Albert R Music Faculty Memorial Building', 
    :latitude => -118.284926, 
    :longitude => 34.023082, 
    :network_id => 1
  },{
    :name => 'Birnkrant', 
    :latitude => -118.281427, 
    :longitude => 34.021544, 
    :network_id => 1
  },{
    :name => 'Student Union', 
    :latitude => -118.28575, 
    :longitude => 34.020230, 
    :network_id => 1
  },{
    :name => 'John Hubbard Hall', 
    :latitude => -118.283115, 
    :longitude => 34.019345, 
    :network_id => 1
  },{
    :name => 'David Marks Tennis Stadium', 
    :latitude => -118.289659, 
    :longitude => 34.022289, 
    :network_id => 1
  },{
    :name => 'David Marks Residence Hall', 
    :latitude => -118.282449, 
    :longitude => 34.019678, 
    :network_id => 1
  },{
    :name => 'Elisabeth Von Kleismid Memorial Residence Hall', 
    :latitude => -118.281441, 
    :longitude => 34.020604, 
    :network_id => 1
  },{
    :name => 'May Ormerod Harris Residence Hall', 
    :latitude => -118.281284, 
    :longitude => 34.021480, 
    :network_id => 1
  },{
    :name => 'College Residence Hall', 
    :latitude => -118.281197, 
    :longitude => 34.020500, 
    :network_id => 1
  },{
    :name => 'University Residence Hall', 
    :latitude => -118.280962, 
    :longitude => 34.021337, 
    :network_id => 1
  },{
    :name => 'Hazel & Stanley Hall Financial Services Building', 
    :latitude => -118.287206, 
    :longitude => 34.020156, 
    :network_id => 1
  },{
    :name => 'Seeley  G Mudd ', 
    :latitude => -118.288894, 
    :longitude => 34.021524, 
    :network_id => 1
  },{
    :name => 'Corwin D Denney Research Center', 
    :latitude => -118.290383, 
    :longitude => 34.021554, 
    :network_id => 1
  },{
    :name => 'Town & Gown', 
    :latitude => -118.283618, 
    :longitude => 34.018319, 
    :network_id => 1
  },{
    :name => 'Stonier Hall', 
    :latitude => -118.287066, 
    :longitude => 34.020093, 
    :network_id => 1
  },{
    :name => 'Faculty Center-University Club', 
    :latitude => -118.283826, 
    :longitude => 34.018839, 
    :network_id => 1
  },{
    :name => 'Parkside Apartments', 
    :latitude => -118.290372, 
    :longitude => 34.018907, 
    :network_id => 1
  },{
    :name => 'Robert Glen Rapp Engineering Research Building', 
    :latitude => -118.287263, 
    :longitude => 34.020146, 
    :network_id => 1
  },{
    :name => 'Trojan Residence Hall', 
    :latitude => -118.282145, 
    :longitude => 34.019486, 
    :network_id => 1
  },{
    :name => 'Jerry & Nancy Neely Petroleum & Chemical Engineering Building', 
    :latitude => -118.289284, 
    :longitude => 34.020086, 
    :network_id => 1
  },{
    :name => 'McDonalds Olympic Swim Stadium', 
    :latitude => -118.287947, 
    :longitude => 34.023765, 
    :network_id => 1
  },{
    :name => 'Jefferson Building', 
    :latitude => -118.287102, 
    :longitude => 34.025027, 
    :network_id => 1
  },{
    :name => 'John Stauffer Hall of Science', 
    :latitude => -118.287241, 
    :longitude => 34.019226, 
    :network_id => 1
  },{
    :name => 'John Stauffer Science Lecture Hall', 
    :latitude => -118.287241, 
    :longitude => 34.019226, 
    :network_id => 1
  },{
    :name => 'Parkside Residential Building', 
    :latitude => -118.289536, 
    :longitude => 34.018831, 
    :network_id => 1
  },{
    :name => 'Hoffman Hall', 
    :latitude => -118.285352, 
    :longitude => 34.018565, 
    :network_id => 1
  },{
    :name => 'Willis Booth Ferris Rehearsal Hall', 
    :latitude => -118.284823, 
    :longitude => 34.023037, 
    :network_id => 1
  },{
    :name => 'Olin Hall of Engineering', 
    :latitude => -118.289591, 
    :longitude => 34.020702, 
    :network_id => 1
  },{
    :name => 'Marks Tower', 
    :latitude => -118.282077, 
    :longitude => 34.019704, 
    :network_id => 1
  },{
    :name => 'University Club at King Stoops Hall', 
    :latitude => -118.283132, 
    :longitude => 34.022609, 
    :network_id => 1
  },{
    :name => 'Grace Ford Salvatori Hall', 
    :latitude => -118.287192, 
    :longitude => 34.021192, 
    :network_id => 1
  },{
    :name => 'Pardee Tower', 
    :latitude => -118.282589, 
    :longitude => 34.020020, 
    :network_id => 1
  },{
    :name => 'The Music Complex', 
    :latitude => -118.285895, 
    :longitude => 34.023222, 
    :network_id => 1
  },{
    :name => 'Cinema Television Center Complex', 
    :latitude => -118.285895, 
    :longitude => 34.023222, 
    :network_id => 1
  },{
    :name => 'Hedco Neurosciences Building', 
    :latitude => -118.288051, 
    :longitude => 34.020630, 
    :network_id => 1
  },{
    :name => 'Kaprielian Hall', 
    :latitude => -118.291453, 
    :longitude => 34.022555, 
    :network_id => 1
  },{
    :name => 'University Bookstore', 
    :latitude => -118.285657, 
    :longitude => 34.020502, 
    :network_id => 1
  },{
    :name => 'Hughes Aircraft Electrical Engineering Center', 
    :latitude => -118.290117, 
    :longitude => 34.019728, 
    :network_id => 1
  },{
    :name => 'Leavey Library', 
    :latitude => -118.281451, 
    :longitude => 34.020643, 
    :network_id => 1
  },{
    :name => 'Ralph & Goldy Lewis Hall', 
    :latitude => -118.282883, 
    :longitude => 34.019242, 
    :network_id => 1
  },{
    :name => 'Popovich Hall', 
    :latitude => -118.282324, 
    :longitude => 34.018379, 
    :network_id => 1
  },{
    :name => 'Loker Track Stadium', 
    :latitude => -118.288526, 
    :longitude => 34.022801, 
    :network_id => 1
  },{
    :name => 'Internationally Themed Residential College', 
    :latitude => -118.290968, 
    :longitude => 34.019375, 
    :network_id => 1
  },{
    :name => 'Social Work Center', 
    :latitude => -118.281313, 
    :longitude => 34.021528, 
    :network_id => 1
  },{
    :name => 'Ronald Tutor Hall of Engineering', 
    :latitude => -118.289959, 
    :longitude => 34.020137, 
    :network_id => 1
  },{
    :name => 'Dornsife Neuroscience Imaging Center', 
    :latitude => -118.288894, 
    :longitude => 34.021524, 
    :network_id => 1
  },{
    :name => 'School of Cinematic Arts', 
    :latitude => -118.287198, 
    :longitude => 34.02333, 
    :network_id => 18}
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

