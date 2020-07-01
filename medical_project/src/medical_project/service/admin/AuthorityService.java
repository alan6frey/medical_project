package medical_project.service.admin;

import java.util.List;

import org.springframework.stereotype.Service;

import medical_project.entity.admin.Authority;

@Service
public interface AuthorityService {
	public int add(Authority authority);
	public int deleteByRoleId(Long roleId);
	public List<Authority> findListByRoleId(Long roleId);
}
