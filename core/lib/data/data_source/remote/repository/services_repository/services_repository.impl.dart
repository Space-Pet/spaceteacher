import 'package:injectable/injectable.dart';

import '../../data_repository.dart';
import 'services_repository.dart';

const serviceProperties = '''
metadata
id
detailed_description
contents {
  language
  name
  description
  slug
}
icon_url
locations
working_days
commitments {
  commitment {
    icon_url
    name
    description
  }
}
additional_services  {
  additional_service  {
    id
    icon_url
    name
    description
    cost
    currency_code
    time_unit
    disabled
    cost_only
  }
}
service_charge
currency_code
service_items(where: {disabled: {_eq: false}, status: {_eq: "active"}, type_service_item: {_is_null: true}}) {
  id
  name
  working_time
  type
  avatar_url 
  description 
  value
  price
}
service_tools{
  id
  name
  image
}

limit_day_booking
''';

@Singleton(as: ServicesRepository)
class ServicesRepositoryImpl
    with DataRepository
    implements ServicesRepository {}
