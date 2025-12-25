//

// abstract class ServicesType {
//   static int selectedIndex = 0;
//   static final List<String> services = [
//     S.current.medical_services,
//     S.current.roadside_services,
//   ];
// }

enum ServicesBaseType {
  roadside,
  medical,
}

enum ServicesType {
  services_individuals,
  services_corporates,
}

ServicesType servicesType = ServicesType.services_corporates;

ServicesBaseType selectedServices = ServicesBaseType.roadside;
